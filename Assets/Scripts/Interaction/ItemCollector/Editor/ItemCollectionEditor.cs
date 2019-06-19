using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(ItemCollection))]
public class ItemCollectionGroupEditor : Editor
{
    public override void OnInspectorGUI()
    {
        base.OnInspectorGUI();

        if(GUILayout.Button("Find Items in current scene"))
        {
            ((ItemCollection)target).SetItems(FindItems().ToArray());
        }
    }

    public HashSet<int> FindItems()
    {
        InteractableItem[] items = FindObjectsOfType<InteractableItem>();
        HashSet<InteractableItem> uniqueItems = new HashSet<InteractableItem>();

        Debug.Log("items found: " + items.Length);

        foreach(InteractableItem item in items)
        {
            if(!uniqueItems.Contains(item) && item.IsViewable)
            {
                uniqueItems.Add(item);
            }
        }

        HashSet<int> ids = new HashSet<int>();
        foreach (InteractableItem item in uniqueItems)
        {
            if (!ids.Contains(item.ID))
            {
                ids.Add(item.ID);
            }
        }

        Debug.Log("unique items found " + uniqueItems.Count);

        return ids;
    }
}
