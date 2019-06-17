﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;
using System;
using ServiceLocatorNamespace;

public class InGameUI : MonoBehaviour
{
    [SerializeField, ScenePath] string menuScene;

    [SerializeField] private GameObject sidebarRoot;
    [SerializeField] private TextMeshProUGUI location;
    [SerializeField] private Button homeButton;
    [SerializeField] private Button replayButton;
    [SerializeField] private Toggle pauseButton;
    [SerializeField] private TogglePanelPair infoPair;
    [SerializeField] private TogglePanelPair settingsPair;
    [SerializeField] private Animation fadeAnimation;

    public SidebarUI Sidebar => sidebar;
    [SerializeField, HideInInspector] private SidebarUI sidebar;

    private PopupService popupService;
    private SceneManagerService sceneManager;
    private LocationDatabaseService locationService;

    private void OnValidate()
    {
        sidebar = GetComponent<SidebarUI>();
    }

    private void Start()
    {
        popupService = ServiceLocator.Instance.Get<PopupService>() as PopupService;
        sceneManager = ServiceLocator.Instance.Get<SceneManagerService>() as SceneManagerService;
        locationService = ServiceLocator.Instance.Get<LocationDatabaseService>() as LocationDatabaseService;

        SetupIntroUI();
    }

    private void OnEnable()
    {
        homeButton.onClick.AddListener(OnHomeButtonPressedEvent);
        replayButton.onClick.AddListener(OnReplayButtonPressedEvent);
        pauseButton.onValueChanged.AddListener(OnPauseTogglePressed);

        infoPair.OnEnable();
        settingsPair.OnEnable();
    }

    private void OnDisable()
    {
        homeButton.onClick.RemoveListener(OnHomeButtonPressedEvent);
        replayButton.onClick.RemoveListener(OnReplayButtonPressedEvent);
        pauseButton.onValueChanged.RemoveListener(OnPauseTogglePressed);

        infoPair.OnDisable();
        settingsPair.OnDisable();
    }

    private void SetupIntroUI()
    {
        int locationID = sceneManager.CurrentLocationID;
        if (locationID != SceneManagerService.MENU_ID)
        {
            LocationsData locationData = locationService.GetLocationData(locationID);
            location.text = locationData.Name;
        }

        fadeAnimation.Play();
    }

    private void OnHomeButtonPressedEvent()
    {
        sidebar.Close();
        (ServiceLocator.Instance.Get<ARManagerService>() as ARManagerService).EnableAR(false);
        sceneManager.LoadScene(menuScene);
    }

    private void OnPauseTogglePressed(bool toggle)
    {
        if (toggle)
        {
            GameTimeManager.PauseGame();
        }
        else
        {
            GameTimeManager.ResumeGame();
        }
    }

    private void OnReplayButtonPressedEvent()
    {
        // TODO: call scenario reset functionality
        popupService.InstantiatePopup(
            "",
            "Weet u zeker dat u het verhaal opnieuw wilt afspelen? \n [Deze functie werkt nog niet en doet niets]",
            new PopupButton.Settings("Ja", null),
            new PopupButton.Settings("Nee", null)
        );
    }
}
