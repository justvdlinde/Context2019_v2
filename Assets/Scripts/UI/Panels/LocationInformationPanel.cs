using ServiceLocatorNamespace;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class LocationInformationPanel : MonoBehaviour
{
    [SerializeField] private bool searchLocationDataSelf;
    [SerializeField] private LocationScenarioFlagPair[] locationScenarioPair;

    [Header("Child References")]
    [SerializeField] private RawImage markerImage;
    [SerializeField] private TextMeshProUGUI title;
    [SerializeField] private TextMeshProUGUI information;
    [SerializeField] private TextMeshProUGUI itemsFoundValue;
    [SerializeField] private Toggle storyCompletedToggle;

    private SceneManagerService sceneManager;
    private LocationDatabaseService locationService;
    private ScenarioFlagsService flagService;
    private ItemCollectionService itemCollectionService;

    private bool init;

    private void Init()
    {
        flagService = ServiceLocator.Instance.Get<ScenarioFlagsService>() as ScenarioFlagsService;
        sceneManager = ServiceLocator.Instance.Get<SceneManagerService>() as SceneManagerService;
        locationService = ServiceLocator.Instance.Get<LocationDatabaseService>() as LocationDatabaseService;
        itemCollectionService = ServiceLocator.Instance.Get<ItemCollectionService>() as ItemCollectionService;

        init = true;
    }

    private void OnEnable()
    {
        if(!init) { Init(); }

        if (searchLocationDataSelf)
        {
            int locationID = sceneManager.CurrentLocationID;
            if (locationID == SceneManagerService.MENU_ID) { return; }

            Setup(locationID);
        }
    }
    
    public void Setup(int locationID)
    {
        if(!init) { Init(); }

        LocationsData locationData = locationService.GetLocationData(locationID);

        title.text = locationData.Name;
        information.text = locationData.Description;

        LocationScenarioFlagPair locationInfo = locationScenarioPair[GetLocationIndex(locationData)];
        markerImage.texture = locationInfo.markerTexture;
        storyCompletedToggle.isOn = flagService.FlagConditionHasBeenMet(locationInfo.scenarioFlag);

        itemsFoundValue.text = GetCollectedItemsCount(locationID) + "/" + itemCollectionService.GetMaxItemsForScene(locationID);
    }

    private int GetLocationIndex(LocationsData data)
    {
        for (int i = 0; i < locationScenarioPair.Length; i++)
        {
            LocationsData d = locationService.GetLocationData(locationScenarioPair[i].location);
            if (data == d)
            {
                return i;
            }
        }

        return -1;
    }

    private int GetCollectedItemsCount(int sceneID)
    {
        return itemCollectionService.GetCollectedItemsForScene(sceneID);
    }
}

[System.Serializable]
public class LocationScenarioFlagPair
{
    [LocationID] public int location;
    [ScenarioFlag] public int scenarioFlag;
    public Texture markerTexture;
}
