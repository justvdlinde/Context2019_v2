using ServiceLocatorNamespace;
using UnityEngine;
using UnityEngine.Playables;

public class TimelineMarkerReceiver : MonoBehaviour, INotificationReceiver
{
    private ScenarioFlagsService flagService;
    private ScenarioHintService hintService;

    private void Start()
    {
        flagService = ServiceLocator.Instance.Get<ScenarioFlagsService>() as ScenarioFlagsService;
        hintService = ServiceLocator.Instance.Get<ScenarioHintService>() as ScenarioHintService;
    }

    public void OnNotify(Playable origin, INotification notification, object context)
    {
        if(notification is TimelineFlagMarker)
        {
            flagService.AddFlag((notification as TimelineFlagMarker).ScenarioFlag);
            return;
        }

        if(notification is TimelineHintMarker)
        {
            hintService.SetCurrentHint((notification as TimelineHintMarker).Hint);
        }
    }
}
