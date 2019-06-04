using ServiceLocatorNamespace;
using System;
using UnityEngine;
using UnityEngine.Events;

public class FlagConditionCheck : MonoBehaviour
{
    [SerializeField] private Condition[] conditions;

    [SerializeField] private UnityEvent onConditionsTrue;
    [SerializeField] private UnityEvent onConditionsFalse;

    private ScenarioFlagsService flagService;
    
    private void Awake()
    {
        flagService = ServiceLocator.Instance.Get<ScenarioFlagsService>() as ScenarioFlagsService;

        if (ConditionsAreMet())
        {
            onConditionsTrue.Invoke();
        }
        else
        {
            onConditionsFalse.Invoke();
        }
    }

    private bool ConditionsAreMet()
    {
        bool returnValue = true;
        foreach (Condition condition in conditions)
        {
            bool check = flagService.FlagConditionHasBeenMet(condition.flag);
            returnValue = check == Convert.ToBoolean(condition.boolCondition);
            if (!returnValue) { return false; }
        }
        
        return returnValue;
    }
}

[Serializable]
public class Condition
{
    public enum BoolCheck
    {
        False = 0,
        True = 1
    }

    [ScenarioFlag] public int flag;
    public BoolCheck boolCondition;
}
