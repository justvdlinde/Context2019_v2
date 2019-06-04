using ServiceLocatorNamespace;
using System;
using UnityEngine;

public class SceneManagerService : MonoBehaviour, IService
{
    [SerializeField] private GameObject root;
    [SerializeField] private LocationScenePair[] locationScenePairs;

    public const int MENU_ID = -1;
    public int CurrentLocationID { get; private set; } = MENU_ID;

    private void Awake()
    {
        if (ServiceLocator.Instance.ContainsService<ARManagerService>())
        {
            Destroy(gameObject);
            return;
        }

        ServiceLocator.Instance.AddService(this);
        DontDestroyOnLoad(this);
        ShowLoadingbar(false);
    }

    public void LoadScene(string scene, Action onDone = null)
    {
        ShowLoadingbar(true);
        onDone += () => ShowLoadingbar(false);

        GameTimeManager.ResumeGame();
        StartCoroutine(SceneManagerUtility.LoadScene(scene, onDone));
        CurrentLocationID = GetNewLocation(scene);
    }

    private int GetNewLocation(string newScene)
    {
        foreach(LocationScenePair pair in locationScenePairs)
        {
            if(pair.scene == newScene)
            {
                return pair.locationID;
            }
        }

        return MENU_ID;
    }

    public void ShowLoadingbar(bool show)
    {
        enabled = show;
        root.SetActive(show);
    }
}

[Serializable]
public class LocationScenePair
{
    [LocationID] public int locationID;
    [ScenePath] public string scene;
}