using System;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

[CustomPropertyDrawer(typeof(Condition))]
public class ConditionPropertyDrawer : PropertyDrawer
{
    private SerializedProperty flag, boolCondition;
    private string name;

    public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
    {
        name = property.displayName;
        property.Next(true);
        flag = property.Copy();
        property.Next(true);
        boolCondition = property.Copy();

        Rect contentPosition = EditorGUI.PrefixLabel(position, new GUIContent(name));

        EditorGUIUtility.labelWidth = 5f;
        contentPosition.width *= 0.7f;

        EditorGUI.BeginProperty(contentPosition, label, flag);
        {
            EditorGUI.PropertyField(contentPosition, flag);
        }
        EditorGUI.EndProperty();

        contentPosition.x += contentPosition.width;
        contentPosition.width *= 0.4f;

        EditorGUI.BeginProperty(contentPosition, label, boolCondition);
        {
            boolCondition.enumValueIndex = (int)(Condition.BoolCheck)EditorGUI.EnumPopup(contentPosition, (Condition.BoolCheck)Enum.GetValues(typeof(Condition.BoolCheck)).GetValue(boolCondition.enumValueIndex));
        }
        EditorGUI.EndProperty();
    }
}
