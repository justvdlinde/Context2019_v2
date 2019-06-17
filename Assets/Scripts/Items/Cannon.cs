using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cannon : MonoBehaviour
{
    [SerializeField] private new Collider collider;
    [SerializeField] private ParticleSystem particleSystem;
    [SerializeField] private AudioSource audioSource;
    [SerializeField] private ScenarioItemInteractionFlagTrigger flagTrigger;
    [SerializeField] private ScenarioItemInteractionHintTrigger hintTrigger;

    [Header("Shake Settings")]
    [SerializeField] private float shakeDuration = 1;
    [SerializeField] private float magnitudeStrength = 1;
    [SerializeField] private AnimationCurve magnitudeCurve;

    public void OnInteractionStart()
    {
        collider.enabled = false;
        particleSystem.Play();
        audioSource.Play();
        flagTrigger.enabled = true;
        hintTrigger.enabled = true;

        // quick hack, need to fix later
        CameraShakeController shaker = Camera.main.GetComponent<CameraShakeController>();
        shaker?.Shake(shakeDuration, magnitudeCurve, magnitudeStrength);
    }
}
