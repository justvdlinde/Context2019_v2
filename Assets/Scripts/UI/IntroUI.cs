using ServiceLocatorNamespace;
using UnityEngine;
using UnityEngine.UI;

public class IntroUI : MonoBehaviour
{
    [SerializeField, ScenePath] private string mainMenu;

    [Header("Child References")]
    [SerializeField] private Button languageButtonNL;
    [SerializeField] private Button languageButtonEN;
    [SerializeField] private Button continueButton;
    [SerializeField] private GameObject uiRoot;
    [SerializeField] private GameObject languageRoot;
    [SerializeField] private GameObject introRoot;

    private SceneManagerService sceneManager;

    private void Start()
    {
        sceneManager = ServiceLocator.Instance.Get<SceneManagerService>() as SceneManagerService;

        uiRoot.SetActive(true);
        languageRoot.SetActive(true);
        introRoot.SetActive(false);
    }

    private void OnEnable()
    {
        languageButtonNL.onClick.AddListener(OnLanguageNLPressed);
        languageButtonEN.onClick.AddListener(OnLanguageENPressed);
        continueButton.onClick.AddListener(OnContinueButtonClicked);
    }

    private void OnDisable()
    {
        languageButtonNL.onClick.RemoveListener(OnLanguageNLPressed);
        languageButtonEN.onClick.RemoveListener(OnLanguageENPressed);
        continueButton.onClick.RemoveListener(OnContinueButtonClicked);
    }

    private void OnLanguageNLPressed()
    {
        ShowIntro();
    }

    private void OnLanguageENPressed()
    {
        ShowIntro();
    }

    private void ShowIntro()
    {
        languageRoot.SetActive(false);
        introRoot.SetActive(true);
    }

    private void OnContinueButtonClicked()
    {
        sceneManager.LoadScene(mainMenu);
    }
}
