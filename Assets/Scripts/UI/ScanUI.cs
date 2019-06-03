using UnityEngine;
using UnityEngine.UI;

public class ScanUI : MonoBehaviour
{
    [SerializeField] private Button homeButton;
    [SerializeField] private Transform imageRoot;

    [SerializeField, HideInInspector] private SidebarUI sidebarUI;
    [SerializeField, HideInInspector] private MainMenuUI menuUI;

    private ARManagerService arManager;

    private void Start()
    {
        arManager = ServiceLocatorNamespace.ServiceLocator.Instance.Get<ARManagerService>() as ARManagerService;
        menuUI = FindObjectOfType<MainMenuUI>();
    }

    private void OnValidate()
    {
        sidebarUI = GetComponent<SidebarUI>();
    }

    private void OnEnable()
    {
        homeButton.onClick.AddListener(OnHomeButtonClickedEvent);
    }

    private void OnDisable()
    {
        homeButton.onClick.RemoveListener(OnHomeButtonClickedEvent);
    }

    private void OnHomeButtonClickedEvent()
    {
        sidebarUI.Close();
        ShowScanOverlay(false);

        arManager.EnableAR(false);
        menuUI.gameObject.SetActive(true);
    }

    public void ShowScanOverlay(bool show)
    {
        imageRoot.gameObject.SetActive(show);
    }
}
