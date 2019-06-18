using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using ServiceLocatorNamespace;

public class GameOverMessageHandler : MonoBehaviour
{
    [SerializeField, ScenarioFlag] private int finalFlag;
    [SerializeField] private string messageHeader;
    [SerializeField, TextArea] private string messageContent;

    private ScenarioFlagsService flagService;
    private PopupService popupService;

    private static GameOverMessageHandler Instance;

    private void Start()
    {
        flagService = ServiceLocator.Instance.Get<ScenarioFlagsService>() as ScenarioFlagsService;
        popupService = ServiceLocator.Instance.Get<PopupService>() as PopupService;

        flagService.FlagAdded += OnFlagAddedEvent;

        if (Instance == null)
        {
            Instance = this; 
            DontDestroyOnLoad(gameObject);
        }
        else
        {
            Destroy(gameObject);
        }
    }

    private void OnFlagAddedEvent(ScenarioFlag flag)
    {
        if(flag.Hash == finalFlag)
        {
            ShowGameOverMessage();
        }
    }

    private void ShowGameOverMessage()
    {
        popupService.InstantiatePopup(messageHeader, messageContent, new PopupButton.Settings("Ok", null));
        flagService.FlagAdded -= OnFlagAddedEvent;
    }
}
