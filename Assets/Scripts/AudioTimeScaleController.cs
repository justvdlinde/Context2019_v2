using UnityEngine;

[RequireComponent(typeof(AudioSource))]
public class AudioTimeScaleController : MonoBehaviour
{
    [SerializeField, HideInInspector] private AudioSource audioSource;

    private void OnValidate()
    {
        audioSource = GetComponent<AudioSource>();
    }

    void Update()
    {
        audioSource.pitch = GameTimeManager.GetCurrentTimeScale;
    }
}
