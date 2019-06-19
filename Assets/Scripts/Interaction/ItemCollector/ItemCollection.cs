using ServiceLocatorNamespace;
using System.Collections.Generic;
using UnityEngine;

public class ItemCollection : ScriptableObject, IService
{
    [LocationID] public int location;
    [ItemID] public int[] items;

    public void SetItems(int[] items)
    {
        this.items = items;
    }
}