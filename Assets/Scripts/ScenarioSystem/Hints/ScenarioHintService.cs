using ServiceLocatorNamespace;
using System;
using System.Collections.Generic;
using UnityEngine;

public class ScenarioHintService : IService
{
    public readonly ScenarioHint[] Hints;

    public Action<ScenarioHint> CurrentHintChangedEvent;
    public ScenarioHint currentHint = null;

    private Dictionary<int, ScenarioHint> hintsDictionary = new Dictionary<int, ScenarioHint>();

    public ScenarioHintService()
    {
        Hints = Resources.LoadAll<ScenarioHint>("");

        foreach(ScenarioHint hint in Hints)
        {
            hintsDictionary.Add(hint.Hash, hint);
        }
    }

    public void SetCurrentHint(ScenarioHint hint)
    {
        currentHint = hint;
        CurrentHintChangedEvent?.Invoke(currentHint);
    }

    public void SetCurrentHint(int hint)
    {
        if (hint == ScenarioHint.None)
        {
            currentHint = null;
        }
        else
        {
            currentHint = hintsDictionary[hint];
        }

        CurrentHintChangedEvent?.Invoke(currentHint);
    }
}
