using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LipSync : MonoBehaviour
{
    public AudioSource audioSource;

    public GameObject mouth;
    public float strength = 40;

    private float[] freqData;
    private int nSamples = 256;
    private int fMax = 24000;

    private float frqLow = 200;
    private float frqHigh = 800;
    private float y0;
 
    private float BandVol(float fLow, float fHigh)
    {
        fLow = Mathf.Clamp(fLow, 20, fMax); // limit low...
        fHigh = Mathf.Clamp(fHigh, fLow, fMax); // and high frequencies
        
        // get spectrum: freqData[n] = vol of frequency n * fMax / nSamples
        audioSource.GetSpectrumData(freqData, 0, FFTWindow.BlackmanHarris);

        float n1 = Mathf.Floor(fLow* nSamples / fMax);
        float n2 = Mathf.Floor(fHigh* nSamples / fMax);
        float sum = 0;

        // average the volumes of frequencies fLow to fHigh
        for (int i = (int)n1; i <= n2; i++)
        {
            sum += freqData[i];
        }
            return sum / (n2 - n1 + 1);
    }
  
    private void Start()
    {
        y0 = mouth.transform.position.y;
        freqData = new float[nSamples];
        audioSource.Play();
    }

    private void Update()
    {
        mouth.transform.position = new Vector3(mouth.transform.position.x, y0 + BandVol(frqLow, frqHigh) * strength, mouth.transform.position.z);
    }
}
