using ServiceLocatorNamespace;
using UnityEngine;

[RequireComponent(typeof(IInteractable))]
public class ScenarioItemInteractionTrigger : MonoBehaviour
{
    [SerializeField, ScenarioFlag] private int interactionStartFlag;
    [SerializeField, ScenarioHint] private int interactionStartHint;
    [SerializeField, ScenarioFlag] private int interactionStopFlag;
    [SerializeField, ScenarioHint] private int interactionStopHint;

    [SerializeField, HideInInspector] private IInteractable interactableObject;

    private ScenarioFlagsService flagService;
    private ScenarioHintService hintService;

    private void OnValidate()
    {
        interactableObject = gameObject.GetInterface<IInteractable>();
    }

    private void OnEnable()
    {
        flagService = ServiceLocator.Instance.Get<ScenarioFlagsService>() as ScenarioFlagsService;
        hintService = ServiceLocator.Instance.Get<ScenarioHintService>() as ScenarioHintService;

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
            flagService.AddFlag(interactionStartFlag);
        }

        if(interactionStartHint != ScenarioHint.None)
        {
            hintService.SetCurrentHint(interactionStartHint);
        }
    }

    private void TriggerInteractionStopEvent()
    {
        if (interactionStopFlag != ScenarioFlag.None)
        {
            flagService.AddFlag(interactionStopFlag);
        }

        if (interactionStopHint != ScenarioHint.None)
        {
            hintService.SetCurrentHint(interactionStopHint);
        }
    }
}
