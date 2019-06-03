using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using ServiceLocatorNamespace;

public class LocationInformationPanel : MonoBehaviour
{
    [SerializeField] private Image markerImage;
    [SerializeField] private TextMeshProUGUI title;
    [SerializeField] private TextMeshProUGUI information;
    [SerializeField] private TextMeshProUGUI itemsFoundValue;
    [SerializeField] private Toggle storyCompletedToggle;

    public void Setup(LocationsData data)
    {
        title.text = data.Name;
        information.text = data.Description;
        itemsFoundValue.text = "0/0";
    }
}
