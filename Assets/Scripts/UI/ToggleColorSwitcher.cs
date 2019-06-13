using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Toggle))]
[RequireComponent(typeof(Image))]
public class ToggleColorSwitcher : MonoBehaviour
{
    [SerializeField] private Color OFFColor;
    [SerializeField] private Color ONColor;

    [SerializeField, HideInInspector] private Toggle toggle;
    [SerializeField, HideInInspector] private Image image;

    private void OnValidate()
    {
        toggle = GetComponent<Toggle>();
        image = GetComponent<Image>();
     }

    private void Start()
    {
        OnToggleValueChanged(toggle.isOn);
        toggle.onValueChanged.AddListener(OnToggleValueChanged);
    }

    private void OnToggleValueChanged(bool isOn)
    {
        image.color = isOn ? ONColor : OFFColor;
    }
}
