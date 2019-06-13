using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEditorInternal;
using UnityEngine;

[CustomEditor(typeof(ScenarioHintCollection))]
public class ScenarioHintCollectionEditor : Editor
{
    private ScenarioHintCollection Hints { get { return target as ScenarioHintCollection; } }

    private ReorderableList reorderableList;
    private SerializedProperty property;

    private string newHintName = "New Hint";

    private void OnEnable()
    {
        reorderableList = new ReorderableList(Hints.collection, typeof(ScenarioHint), true, true, true, true);

        reorderableList.drawHeaderCallback += DrawHeader;
        reorderableList.drawElementCallback += DrawElement;
        reorderableList.onAddCallback += CreateNewHint;
        reorderableList.onRemoveCallback += RemoveItem;

        property = serializedObject.FindProperty("collection");
    }

    private void OnDisable()
    {
        reorderableList.drawHeaderCallback -= DrawHeader;
        reorderableList.drawElementCallback -= DrawElement;
        reorderableList.onAddCallback -= CreateNewHint;
        reorderableList.onRemoveCallback -= RemoveItem;
    }

    private void DrawHeader(Rect rect)
    {
        GUI.Label(rect, "All Hints");
    }

    public override void OnInspectorGUI()
    {
        base.OnInspectorGUI();

        reorderableList.DoLayoutList();
    }

    private void DrawElement(Rect rect, int index, bool active, bool focused)
    {
        float labelHeight = 15;
        float labelMargin = 5;
        float totalHeight = 0;

        ScenarioHint item = Hints.collection[index];
        if(item == null)
        {
            return;
        }

        EditorGUI.BeginChangeCheck();
        string prevName = item.name;
        item.name = EditorGUI.DelayedTextField(new Rect(rect.x + 25, rect.y, rect.width - 25, labelHeight), item.name);
        totalHeight += labelHeight + labelMargin;

        labelHeight = 20 + labelMargin;
        item.hint = EditorGUI.TextArea(new Rect(rect.x, rect.y + totalHeight, rect.width, labelHeight), item.hint);
        totalHeight += labelHeight;

        //EditorGUI.LabelField(new Rect(rect.x, rect.y + totalHeight, rect.width, labelHeight), "Hash: " + item.Hash.ToString());
        //totalHeight += labelHeight;

        reorderableList.elementHeight = totalHeight + labelMargin;

        if (EditorGUI.EndChangeCheck())
        {
            EditorUtility.SetDirty(target);
        }
    }

    private void CreateNewHint(ReorderableList list)
    {
        ScenarioHint hint = CreateNewHint() as ScenarioHint;

        int hash = GenerateHash(hint);

        hint.name = newHintName;
        hint.SetHash(hash);

        Hints.collection.Add(hint);
        EditorUtility.SetDirty(target);
    }

    public ScriptableObject CreateNewHint()
    {
        ScriptableObject instance = CreateInstance(typeof(ScenarioHint));
        instance.hideFlags = HideFlags.None;
        instance.name = newHintName;

        string assetFilePath = AssetDatabase.GetAssetPath(Hints);
        AssetDatabase.AddObjectToAsset(instance, assetFilePath);
        AssetDatabase.ImportAsset(assetFilePath);

        return instance;
    }

    private void RemoveItem(ReorderableList list)
    {
        ScenarioHint hint = Hints.collection[list.index];
        Hints.collection.RemoveAt(list.index);

        string assetFilePath = AssetDatabase.GetAssetPath(Hints);
        AssetDatabase.RemoveObjectFromAsset(hint);
        AssetDatabase.ImportAsset(assetFilePath);

        EditorUtility.SetDirty(target);
    }

    private int GenerateHash(ScriptableObject scriptableObject)
    {
        return scriptableObject.GetInstanceID();
    }
}

