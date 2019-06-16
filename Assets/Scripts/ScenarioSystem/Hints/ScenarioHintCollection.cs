using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScenarioHintCollection : ScriptableObject
{
    [HideInInspector] public List<ScenarioHint> collection = new List<ScenarioHint>();
}
