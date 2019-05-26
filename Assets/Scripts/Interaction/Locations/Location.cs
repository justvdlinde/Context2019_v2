using System;
using UnityEngine;

public class Location : MonoBehaviour, IInteractable
{
    [SerializeField] [LocationID] private int id;
    public int ID => id;

    public GameObject GameObject => gameObject;
    public Collider Collider => GetComponent<Collider>();
    public bool HideAtStart => false;
    public bool DestroyAfterInteraction => false;

    public Action InteractionStartEvent { get; set; }
    public Action InteractionStopEvent { get; set; }

    public void OnInteractionStart()
    {
        OnSelectChange(true);
        InteractionStartEvent?.Invoke();
    }

    public void OnInteractionStop()
    {
        OnSelectChange(false);
        InteractionStopEvent?.Invoke();
    }

    private void OnSelectChange(bool selected)
    {
        // set outline color
    }
}
