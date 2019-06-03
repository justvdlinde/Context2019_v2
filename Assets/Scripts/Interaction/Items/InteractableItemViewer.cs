using System.Collections;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using ServiceLocatorNamespace;

/// <summary>
/// Class for viewing <see cref="InteractableItem"/>s
/// </summary>
public class InteractableItemViewer : MonoBehaviour
{
    [Header("Dependencies")]
    [SerializeField] private InteractionHandler interactionHandler;
    [SerializeField] private ItemViewerUI itemUI;

    [Header("Object References")]
    [SerializeField] private new Camera camera;
    [SerializeField] private Transform itemContainer;

    [Header("Fields")]
    [SerializeField] private Layer viewedItemLayer;
    [SerializeField] private float lerpTime;
    [SerializeField] private float rotateSpeed;
    [SerializeField] private float rotateSpeedMobile;

    private bool isViewing;
    private IInteractable interactableItem;
    private TransformData itemOriginalTransformData;
    private int itemOriginalLayer;

    private ItemDatabaseService itemDatabase;
    private IPlayerInput playerInput;

    private void Start()
    {
        itemDatabase = ServiceLocator.Instance.Get<ItemDatabaseService>() as ItemDatabaseService;
        playerInput = (ServiceLocator.Instance.Get<PlayerInputService>() as PlayerInputService).Input;
    }

    private void OnEnable()
    {
        interactionHandler.InteractedWithObjectEvent += OnInteracedWithObjectEvent;
    }

    private void OnDisable()
    {
        interactionHandler.InteractedWithObjectEvent -= OnInteracedWithObjectEvent;
    }

    private void Update()
    {
        if (isViewing)
        {
            View();
        }
    }

    private void LateUpdate()
    {
        if (Camera.main != null)
        {
            transform.position = Camera.main.transform.position;
            transform.rotation = Camera.main.transform.rotation;
        }
        else
        {
            Debug.LogWarning("No Main Camera found!");
        }
    }

    private void OnCloseButtonPressed()
    {
        StopViewing();
    }

    private void OnInteracedWithObjectEvent(IInteractable interactable)
    {
        if (isViewing) { return; }

        if (interactable is InteractableItem)
        {
            StartViewing(interactable as InteractableItem);
        }
    }

    private void StartViewing(InteractableItem item)
    {
        interactionHandler.SetActive(false);

        isViewing = true;
        interactableItem = item;
        SetUI(itemDatabase.GetItemData(item.ID), item);
        itemUI.StopViewingItemButtonPressedEvent += OnCloseButtonPressed;

        if (item.IsViewable)
        {
            StartCoroutine(LerpItemIntoView(item));
        }
    }

    private void SetUI(ItemsData data, IInteractable interactable)
    {
        itemUI.ShowItemInfoUI(data, interactable);
    }

    private void View()
    {
        if (playerInput.IsPressed)
        {
            Vector3 relativeUp = camera.transform.TransformDirection(Vector3.up);
            Vector3 relativeRight = camera.transform.TransformDirection(Vector3.right);

            Vector3 objectRelativeUp = itemContainer.transform.InverseTransformDirection(relativeUp);
            Vector3 objectRelaviveRight = itemContainer.transform.InverseTransformDirection(relativeRight);

            Quaternion extraRotation = Quaternion.AngleAxis(-playerInput.PositionDelta.x / itemContainer.transform.localScale.x * rotateSpeed, objectRelativeUp)
                                        * Quaternion.AngleAxis(playerInput.PositionDelta.y / itemContainer.transform.localScale.y * rotateSpeed, objectRelaviveRight);

            itemContainer.rotation = itemContainer.transform.rotation * extraRotation;
        }
    }

    private void StopViewing()
    {
        interactableItem.OnInteractionStop();

        if (interactableItem.IsViewable)
        {
            if (!interactableItem.DestroyAfterInteraction)
            {
                StartCoroutine(LerpItemBackToOrigin(interactableItem));
            }
            
            itemContainer.rotation = Quaternion.identity;
        }

        interactionHandler.SetActive(true);
        interactableItem = null;
        isViewing = false;
        itemUI.StopViewingItemButtonPressedEvent -= OnCloseButtonPressed;
    }

    private IEnumerator LerpItemIntoView(IInteractable item)
    {
        camera.enabled = true;
        itemOriginalLayer = item.GameObject.layer;
        item.GameObject.layer = viewedItemLayer.LayerIndex;

        float timeRemaining = lerpTime;
        Transform itemTransform = item.GameObject.transform;
        itemOriginalTransformData = new TransformData(itemTransform);

        while (timeRemaining > 0)
        {
            float lerp = (lerpTime - timeRemaining) / lerpTime;
            itemTransform.rotation = Quaternion.Lerp(itemOriginalTransformData.rotation, itemContainer.rotation, lerp);
            itemTransform.position = Vector3.Lerp(itemOriginalTransformData.position, itemContainer.position, lerp);
            timeRemaining -= Time.deltaTime;
            yield return null;
        }

        itemTransform.SetParent(itemContainer);
        itemTransform.localPosition = Vector3.zero;
        itemTransform.localRotation = Quaternion.identity;
    }

    private IEnumerator LerpItemBackToOrigin(IInteractable item)
    {
        float timeRemaining = lerpTime;
        Transform itemTransform = item.GameObject.transform;
        TransformData start = new TransformData(itemTransform);

        while (timeRemaining > 0)
        {
            float lerp = (lerpTime - timeRemaining) / lerpTime;
            itemTransform.rotation = Quaternion.Lerp(start.rotation, itemOriginalTransformData.rotation, lerp);
            itemTransform.position = Vector3.Lerp(start.position, itemOriginalTransformData.position, lerp);

            timeRemaining -= Time.deltaTime;
            yield return null;
        }

        itemTransform.SetFromData(itemOriginalTransformData);
        itemTransform.gameObject.layer = itemOriginalLayer;
        camera.enabled = false;
        interactionHandler.SetActive(true);
    }
}
