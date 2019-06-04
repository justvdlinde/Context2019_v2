#if UNITY_EDITOR
using UnityEngine;
using ServiceLocatorNamespace;

public class NonARLocationManager : MonoBehaviour
{
    private SceneManagerService sceneManager;
    private ARManagerService arManager;

    private void Start()
    {
        sceneManager = ServiceLocator.Instance.Get<SceneManagerService>() as SceneManagerService;
        arManager = ServiceLocator.Instance.Get<ARManagerService>() as ARManagerService;
    }

    private void OnGUI()
    {
        for (int i = 0; i < arManager.TrackableScenes.Length; i++)
        {
            if (GUI.Button(new Rect(i * 150, 10, 150, 50), arManager.TrackableScenes[i].name))
            {
                sceneManager.LoadScene(arManager.TrackableScenes[i].Scene);
            }
        }
    }
}
#endif