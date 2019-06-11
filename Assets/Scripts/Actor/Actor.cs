using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

[RequireComponent(typeof(Animator))]
public class Actor : MonoBehaviour
{
    [SerializeField] private UnityEvent startup;

    [SerializeField, HideInInspector] private Animator animator;

    private void OnValidate()
    {
        animator = GetComponent<Animator>();
    }

    private void Awake()
    {
        startup.Invoke();
    }

    public void AnimatorSetBoolTrue(string boolParameter)
    {
        animator.SetBool(boolParameter, true);
    }

    public void AnimatorSetBoolFalse(string boolParameter)
    {
        animator.SetBool(boolParameter, false);
    }
}
