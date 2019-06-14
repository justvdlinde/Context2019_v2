using UnityEngine;

public class MobileSettingsManager : MonoBehaviour
{
    [SerializeField] private ScreenOrientation orientation = ScreenOrientation.Landscape;

    private void Start()
    {
        DontDestroyOnLoad(gameObject);

        Screen.orientation = orientation;
        Screen.sleepTimeout = SleepTimeout.NeverSleep;
    }
}
