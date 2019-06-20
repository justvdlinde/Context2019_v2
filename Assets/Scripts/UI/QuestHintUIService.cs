using ServiceLocatorNamespace;
using TMPro;
using UnityEngine;

public class QuestHintUIService : MonoBehaviour, IService
{
    [SerializeField] private TextMeshProUGUI text;
    [SerializeField] private GameObject root;

    private ScenarioHintService hintService;

    private void Awake()
    {
        if (ServiceLocator.Instance.ContainsService<QuestHintUIService>())
        {
            Destroy(gameObject);
            return;
        }

        ServiceLocator.Instance.AddService(this);
        DontDestroyOnLoad(this);
    }

    private void Start()
    {
        hintService = ServiceLocator.Instance.Get<ScenarioHintService>() as ScenarioHintService;
        hintService.CurrentHintChangedEvent += OnCurrentHintChangedEvent; 
    }

    private void OnCurrentHintChangedEvent(ScenarioHint newHint)
    {
        if (newHint == null)
        {
            text.text = string.Empty;
        }
        else
        {
            text.text = newHint.hint;
        }

        root.SetActive(newHint != null);
    }

    private void OnDestroy()
    {
        if (hintService != null)
        {
            hintService.CurrentHintChangedEvent -= OnCurrentHintChangedEvent;
        }
    }
}
