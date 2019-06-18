using ServiceLocatorNamespace;
using UnityEngine;
using UnityEngine.EventSystems;

public class MenuLocationHandler : MonoBehaviour
{
    [SerializeField] private MenuLocationInfoUI locationUI;
    [SerializeField] private new Camera camera;
    [SerializeField] private float maxSelectionOffset = 10;

    private LocationDatabaseService locationsService;
    private RaycastHit hit;
    private Ray ray;
    private Location selectedLocation;
    private Vector3 positionOnMouseDown;

    private void Start()
    {
        locationsService = ServiceLocator.Instance.Get<LocationDatabaseService>() as LocationDatabaseService;
    }

    private void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            positionOnMouseDown = Input.mousePosition;
        }

        if (Input.GetMouseButtonUp(0))
        {
            if (Vector3.Distance(positionOnMouseDown, Input.mousePosition) < maxSelectionOffset)
            { 
                OnClick();
            }
        }
    }

    private void OnClick()
    {
        ray = camera.ScreenPointToRay(Input.mousePosition);
        if (!EventSystem.current.IsPointerOverGameObject() && Physics.Raycast(ray, out hit, Mathf.Infinity))
        {
            IInteractable obj = hit.transform.gameObject.GetInterface<IInteractable>();
            Location location = null;

            if (obj == null)
            {
                return;
            }
            else
            {
                location = obj as Location;
            }

            if (location != null)
            {
                OnInteractableObjectHit(location);
            }
        }
    }

    private void OnInteractableObjectHit(Location location)
    {
        locationUI.Setup(locationsService.GetLocationData(location.ID));

        if(selectedLocation != null)
        {
            selectedLocation.OnInteractionStop();
        }

        selectedLocation = location;
        selectedLocation.OnInteractionStart();
    }
}
