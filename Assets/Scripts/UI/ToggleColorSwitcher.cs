using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

[RequireComponent(typeof(Toggle))]
[RequireComponent(typeof(Image))]
public class ToggleColorSwitcher : MonoBehaviour
{
    [SerializeField] private Color OFFColor;
    [SerializeField] private Color ONColor;

    [SerializeField, HideInInspector] private Toggle toggle;
    [SerializeField, HideInInspector] private Image image;

    private ColorBlock colorBlock;

    private void OnValidate()
    {
        toggle = GetComponent<Toggle>();
        image = GetComponent<Image>();
     }

    private void Start()
    {
        colorBlock = toggle.colors;

        toggle.onValueChanged.AddListener(OnToggleValueChanged);
    }

    private void OnToggleValueChanged(bool isOn)
    {
        image.color = isOn ? ONColor : OFFColor;
    }
}
