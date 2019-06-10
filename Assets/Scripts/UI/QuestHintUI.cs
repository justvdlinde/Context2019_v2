using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using ServiceLocatorNamespace;

public class QuestHintUI : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI text;

    private ScenarioFlagsService flagService;

    private void Start()
    {
        flagService = ServiceLocator.Instance.Get<ScenarioFlagsService>() as ScenarioFlagsService;

    }

    

    private void Show()
    {

    }

    private void Hide()
    {

    }
}
