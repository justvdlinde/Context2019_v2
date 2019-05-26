using ServiceLocatorNamespace;
using UnityEngine;

[RequireComponent(typeof(IInteractable))]
public class ScenarioItemInteractionTrigger : MonoBehaviour
{
    [SerializeField, ScenarioFlag] private int interactionStartFlag;
    [SerializeField, ScenarioFlag] private int interactionStopFlag;

    [SerializeField, HideInInspector] private IInteractable interactableObject;

    private ScenarioFlagsService service;

    private void OnValidate()
    {
        interactableObject = gameObject.GetInterface<IInteractable>();
    }

    private void OnEnable()
    {
        service = ServiceLocator.Instance.Get<ScenarioFlagsService>() as ScenarioFlagsService;

        interactableObject.InteractionStartEvent += TriggerInteractionStartEvent;
        interactableObject.InteractionStopEvent += TriggerInteractionStopEvent;
    }

    private void OnDisable()
    {
        interactableObject.InteractionStartEvent -= TriggerInteractionStartEvent;
        interactableObject.InteractionStopEvent -= TriggerInteractionStopEvent;
    }

    private void TriggerInteractionStartEvent()
    {
        if (interactionStartFlag != ScenarioFlag.None)
        {
            service.AddFlag(interactionStartFlag);
        }
    }

    private void TriggerInteractionStopEvent()
    {
        if (interactionStopFlag != ScenarioFlag.None)
        {
            service.AddFlag(interactionStopFlag);
        }
    }
}
