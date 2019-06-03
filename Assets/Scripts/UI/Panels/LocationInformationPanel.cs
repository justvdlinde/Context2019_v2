using ServiceLocatorNamespace;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class LocationInformationPanel : MonoBehaviour
{
    [SerializeField] private bool searchLocationDataSelf;

    [Header("Child References")]
    [SerializeField] private Image markerImage;
    [SerializeField] private TextMeshProUGUI title;
    [SerializeField] private TextMeshProUGUI information;
    [SerializeField] private TextMeshProUGUI itemsFoundValue;
    [SerializeField] private Toggle storyCompletedToggle;

    private SceneManagerService sceneManager;
    private LocationDatabaseService locationService;

    private void Start()
    {
        if (searchLocationDataSelf)
        {
            sceneManager = ServiceLocator.Instance.Get<SceneManagerService>() as SceneManagerService;
            locationService = ServiceLocator.Instance.Get<LocationDatabaseService>() as LocationDatabaseService;

            LocationsData data = null;
            int locationID = sceneManager.CurrentLocationID;
            if (locationID == SceneManagerService.MENU_ID) { return; }
            data = locationService.GetLocationData(locationID);

            Setup(data);
        }
    }
    
    public void Setup(LocationsData data)
    {
        title.text = data.Name;
        information.text = data.Description;

        // TODO: fill correct value:
        itemsFoundValue.text = "0/0";
    }
}
