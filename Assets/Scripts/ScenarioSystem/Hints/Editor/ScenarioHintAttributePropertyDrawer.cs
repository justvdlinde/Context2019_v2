using ServiceLocatorNamespace;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

[CustomPropertyDrawer(typeof(ScenarioHintAttribute))]
public class ScenarioHintAttributePropertyDrawer : PropertyDrawer
{
    private string[] hintNames;
    private int[] hintHashes;

    private bool init;
    private int selectedHash;

    private void Init(SerializedProperty property)
    {
        ScenarioHintService service = (ScenarioHintService)ServiceLocator.Instance.Get<ScenarioHintService>();
        List<string> hintNamesList = new List<string>();
        List<int> hintHashesList = new List<int>();
        hintNamesList.Add("None");
        hintHashesList.Add(ScenarioHint.None);

        foreach (ScenarioHint hint in service.Hints)
        {
            hintNamesList.Add(hint.name + " - " + hint.hint);
            hintHashesList.Add(hint.Hash);
        }

        hintNames = hintNamesList.ToArray();
        hintHashes = hintHashesList.ToArray();

        init = true;
    }

    public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
    {
        if (!init)
        {
            Init(property);
        }

        EditorGUI.BeginProperty(position, GUIContent.none, property);
        position = EditorGUI.PrefixLabel(position, GUIUtility.GetControlID(FocusType.Passive), label);

        property.intValue = EditorGUI.IntPopup(position, property.intValue, hintNames, hintHashes);

        EditorGUI.EndProperty();
    }
}