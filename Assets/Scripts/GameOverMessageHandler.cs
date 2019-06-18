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

    private void Start()
    {
        flagService = ServiceLocator.Instance.Get<ScenarioFlagsService>() as ScenarioFlagsService;
        popupService = ServiceLocator.Instance.Get<PopupService>() as PopupService;

        DontDestroyOnLoad(gameObject);
        flagService.FlagAdded += OnFlagAddedEvent;
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
