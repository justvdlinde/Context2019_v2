using UnityEngine;
using ServiceLocatorNamespace;

[RequireComponent(typeof(InteractionHandler))]
public class ItemCollectionHandler : MonoBehaviour
{
    [SerializeField] private InteractionHandler interactionHandler;

    private ItemCollectionService itemCollectionService;

    private void OnValidate()
    {
        interactionHandler = GetComponent<InteractionHandler>();
    }

    private void Start()
    {
        itemCollectionService = ServiceLocator.Instance.Get<ItemCollectionService>() as ItemCollectionService;
    }

    private void OnEnable()
    {
        interactionHandler.InteractedWithObjectEvent += OnInteractedWithObjectEvent;
    }

    private void OnDisable()
    {
        interactionHandler.InteractedWithObjectEvent -= OnInteractedWithObjectEvent;
    }

    private void OnInteractedWithObjectEvent(IInteractable interactable)
    {
        if(interactable is InteractableItem)
        {
            itemCollectionService.MarkItemAsCollected((interactable as InteractableItem).ID);
        }
    }
}
