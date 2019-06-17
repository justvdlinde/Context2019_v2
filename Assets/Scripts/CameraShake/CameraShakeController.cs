using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraShakeController : MonoBehaviour
{  
    public void Shake(float duration, AnimationCurve magnitudeCurve, float magnitudeStrength)
    {
        StartCoroutine(ShakeCoroutine(duration, magnitudeCurve, magnitudeStrength));
    }

    private IEnumerator ShakeCoroutine(float duration, AnimationCurve magnitudeCurve, float magnitudeStrength)
    {
        Vector3 orignalPosition = transform.position;
        float elapsed = 0f;

        while (elapsed < duration)
        {
            float curvePosition = magnitudeCurve.Evaluate(elapsed / duration);
            float x = Random.Range(-1f, 1f) * curvePosition * magnitudeStrength;
            float y = Random.Range(-1f, 1f) * curvePosition * magnitudeStrength;

            transform.position = new Vector3(orignalPosition.x + x, orignalPosition.y + y, orignalPosition.z);
            elapsed += Time.deltaTime;
            yield return 0;
        }
        transform.position = orignalPosition;
    }

}
