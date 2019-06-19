using UnityEngine;

public class MenuLocationInfoUI : MonoBehaviour
{
    [SerializeField] private LocationInformationPanel infoPanel;

    [SerializeField, HideInInspector] private SidebarUI sidebar;

    private void OnValidate()
    {
        sidebar = GetComponent<SidebarUI>();
    }

    public void Setup(int id)
    {
        gameObject.SetActive(true);
        sidebar.Open();
        infoPanel.Setup(id);
    }
}
