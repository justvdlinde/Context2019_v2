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

    private bool init;

    private void Init()
    {
        flagService = ServiceLocator.Instance.Get<ScenarioFlagsService>() as ScenarioFlagsService;
        sceneManager = ServiceLocator.Instance.Get<SceneManagerService>() as SceneManagerService;
        locationService = ServiceLocator.Instance.Get<LocationDatabaseService>() as LocationDatabaseService;

        init = true;
    }

    private void Start()
    {
        if(!init) { Init(); }

        if (searchLocationDataSelf)
        {
            LocationsData data = null;
            int locationID = sceneManager.CurrentLocationID;
            if (locationID == SceneManagerService.MENU_ID) { return; }
            data = locationService.GetLocationData(locationID);

            Setup(data);
        }
    }
    
    public void Setup(LocationsData data)
    {
        if(!init) { Init(); }

        title.text = data.Name;
        information.text = data.Description;

        LocationScenarioFlagPair locationInfo = locationScenarioPair[GetLocationIndex(data)];
        markerImage.texture = locationInfo.markerTexture;
        storyCompletedToggle.isOn = flagService.FlagConditionHasBeenMet(locationInfo.scenarioFlag);

        // TODO: fill correct value:
        itemsFoundValue.text = "0/0";
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
}

[System.Serializable]
public class LocationScenarioFlagPair
{
    [LocationID] public int location;
    [ScenarioFlag] public int scenarioFlag;
    public Texture markerTexture;
}
