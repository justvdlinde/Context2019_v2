using ServiceLocatorNamespace;
using UnityEngine;
using UnityEngine.Events;

public class ScenarioFlagListener : MonoBehaviour
{
    [SerializeField, ScenarioFlag] private int flag;

    private ScenarioFlagsService flagService;

    [SerializeField] private UnityEvent onFlagAddedEvent;

    private void Start()
    {
        flagService = ServiceLocator.Instance.Get<ScenarioFlagsService>() as ScenarioFlagsService;
        flagService.FlagAdded += OnFlagAdded;
    }

    private void OnDestroy()
    {
        if (flagService != null)
        {
            flagService.FlagAdded -= OnFlagAdded;
        }
    }

    private void OnFlagAdded(ScenarioFlag flag)
    {
        if(flag.Equals(this.flag))
        {
            onFlagAddedEvent.Invoke();
        }
    }
}
