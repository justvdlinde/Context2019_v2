using UnityEngine;

public class ScenarioHint : ScriptableObject
{
    public const int None = 0;

    public int Hash => hash;
    [SerializeField] private int hash;

    public string hint;

    public void SetHash(int hash)
    {
        this.hash = hash;
    }

    public override int GetHashCode()
    {
        return hash;
    }
}