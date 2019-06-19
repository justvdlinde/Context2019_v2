using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CastleGate : MonoBehaviour
{
    [SerializeField] private new Animation animation;
    [SerializeField] private AudioSource audioSource;

    public void Open()
    {
        animation.Play();
        audioSource.Play();
    }
}
