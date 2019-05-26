using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class InteractableTrigger : MonoBehaviour, IInteractable
{
    public GameObject GameObject => gameObject;
    public Collider Collider => GetComponent<Collider>();

    public bool HideAtStart => true;
    public bool DestroyAfterInteraction => false;

    public Action InteractionStartEvent { get; set; }
    public Action InteractionStopEvent { get; set; }

    [SerializeField] private UnityEvent interactionStartEvent;
    [SerializeField] private UnityEvent interactionStopUnityEvent;

    public void OnInteractionStart()
    {
        InteractionStartEvent?.Invoke();
        interactionStartEvent.Invoke();
    }

    public void OnInteractionStop()
    {
        InteractionStartEvent?.Invoke();
        interactionStopUnityEvent.Invoke();
    }
}
