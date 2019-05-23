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

    [SerializeField] private UnityEvent interactionStartEvent;
    [SerializeField] private UnityEvent interactionStopEvent;

    public void OnInteractionStart()
    {
        interactionStartEvent.Invoke();
    }

    public void OnInteractionStop()
    {
        interactionStopEvent.Invoke();
    }
}
