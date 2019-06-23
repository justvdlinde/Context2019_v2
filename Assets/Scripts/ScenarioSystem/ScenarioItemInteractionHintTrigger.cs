using ServiceLocatorNamespace;
using UnityEngine;

[RequireComponent(typeof(IInteractable))]
public class ScenarioItemInteractionHintTrigger : MonoBehaviour
{
    [SerializeField, ScenarioHint] private int interactionStartHint;

    [SerializeField, HideInInspector] private IInteractable interactableObject;

    private ScenarioHintService hintService;

    private void OnEnable()
    {
        hintService = ServiceLocator.Instance.Get<ScenarioHintService>() as ScenarioHintService;
        interactableObject = gameObject.GetInterface<IInteractable>();
        interactableObject.InteractionStartEvent += TriggerInteractionStartEvent;
    }

    private void OnDisable()
    {
        interactableObject.InteractionStartEvent -= TriggerInteractionStartEvent;
    }

    private void TriggerInteractionStartEvent()
    {
        hintService.SetCurrentHint(interactionStartHint);   
    }
}
