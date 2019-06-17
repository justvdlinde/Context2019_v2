using UnityEngine;
using ServiceLocatorNamespace;

public class RoomExitTrigger : MonoBehaviour
{
    [SerializeField, ScenePath] private string menuScene;

    public void OnTriggerEnter(Collider other)
    {
        (ServiceLocator.Instance.Get<ARManagerService>() as ARManagerService).EnableAR(false);
        (ServiceLocator.Instance.Get<SceneManagerService>() as SceneManagerService).LoadScene(menuScene);
    }
}
