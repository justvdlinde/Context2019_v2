using UnityEditor;
using UnityEngine;

[CustomPropertyDrawer(typeof(IntMinMax))]
public class IntMinMaxPropertyDrawer : PropertyDrawer
{
    private SerializedProperty min, max;
    private string name;

    public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
    {
        name = property.displayName;
        property.Next(true);
        min = property.Copy();
        property.Next(true);
        max = property.Copy();

        Rect contentPosition = EditorGUI.PrefixLabel(position, new GUIContent(name));

        EditorGUIUtility.labelWidth = 25f;
        contentPosition.width *= 0.5f;

        EditorGUI.BeginProperty(contentPosition, label, min);
        {
            EditorGUI.BeginChangeCheck();
            int newVal = EditorGUI.IntField(contentPosition, new GUIContent("Min"), min.intValue);
            if (EditorGUI.EndChangeCheck())
                min.intValue = newVal;
        }
        EditorGUI.EndProperty();

        contentPosition.x += contentPosition.width;

        EditorGUI.BeginProperty(contentPosition, label, max);
        {
            EditorGUI.BeginChangeCheck();
            int newVal = EditorGUI.IntField(contentPosition, new GUIContent("Max"), max.intValue);
            if (EditorGUI.EndChangeCheck())
                max.intValue = newVal;
        }
        EditorGUI.EndProperty();
    }
}