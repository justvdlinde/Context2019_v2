using ServiceLocatorNamespace;
using UnityEngine;

[RequireComponent(typeof(IInteractable))]
public class ScenarioItemInteractionFlagTrigger : MonoBehaviour
{
    [SerializeField, ScenarioFlag] private int interactionStartFlag;

    [SerializeField, HideInInspector] private IInteractable interactableObject;

    private ScenarioFlagsService flagService;

    private void OnValidate()
    {
        interactableObject = gameObject.GetInterface<IInteractable>();
    }

    private void OnEnable()
    {
        flagService = ServiceLocator.Instance.Get<ScenarioFlagsService>() as ScenarioFlagsService;

        interactableObject.InteractionStartEvent += TriggerInteractionStartEvent;
    }

    private void OnDisable()
    {
        interactableObject.InteractionStartEvent -= TriggerInteractionStartEvent;
    }

    private void TriggerInteractionStartEvent()
    {
        Debug.Log("TriggerInteractionStartEvent");

        if (interactionStartFlag != ScenarioFlag.None)
        {
            flagService.AddFlag(interactionStartFlag);
        }
    }
}
