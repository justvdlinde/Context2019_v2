using System;
using UnityEngine;

public interface IInteractable 
{
    Action InteractionStartEvent { get; set; }
    Action InteractionStopEvent { get; set; }

    GameObject GameObject { get; }
    Collider Collider { get; }
    bool HideAtStart { get; }
    bool DestroyAfterInteraction { get; }
    bool IsViewable { get; }

    void OnInteractionStart();
    void OnInteractionStop();
}
