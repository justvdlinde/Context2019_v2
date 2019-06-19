using ServiceLocatorNamespace;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;

public class ItemCollectionService : IService
{
    public ItemCollection[] ItemCollections { get; private set; }

    public HashSet<int> collectedItems = new HashSet<int>();

    public ItemCollectionService()
    {
        ItemCollections = Resources.LoadAll<ItemCollection>("");
        ItemCollections.OrderBy(collection => collection.location);
    }

    public void MarkItemAsCollected(int itemID)
    {
        collectedItems.Add(itemID);
    }
    
    public int GetCollectedItemsForScene(int scene)
    {
        ItemCollection itemsInScene = ItemCollections[scene];

        int count = 0;
        foreach(int itemID in itemsInScene.items)
        {
            if(collectedItems.Contains(itemID))
            {
                count++;
            }
        }

        return count;
    }

    public int GetMaxItemsForScene(int scene)
    {
        return ItemCollections[scene].items.Length;
    }
}
