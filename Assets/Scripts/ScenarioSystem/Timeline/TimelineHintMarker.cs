using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public class TimelineHintMarker : Marker, INotification, INotificationOptionProvider
{
    [SerializeField, ScenarioHint] private int hint;
    public int Hint => hint;

    public PropertyName id { get { return new PropertyName(); } }

    public NotificationFlags flags => NotificationFlags.TriggerOnce;
}
