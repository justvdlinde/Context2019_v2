using System.Linq;
using UnityEngine;

[RequireComponent(typeof(Animator))]
public class FootStepEventHandler : MonoBehaviour
{
    [SerializeField, HideInInspector] private FootStepSoundController[] controllers;

    private void OnValidate()
    {
        controllers = GetComponentsInChildren<FootStepSoundController>().OrderBy(x => x.Foot).ToArray();
    }

    private void PlaceFootEvent(AnimationEvent animationEvent)
    {
        int foot = animationEvent.intParameter;
        float volume = animationEvent.floatParameter;
        
        controllers[foot].CheckForFloor(volume);
    }
}
