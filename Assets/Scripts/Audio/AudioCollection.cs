using UnityEngine;

public class AudioCollection : ScriptableObject
{
    public AudioClip[] Clips => clips;
    [SerializeField] private AudioClip[] clips;

    public AudioClip GetRandom()
    {
        return clips.GetRandom();
    }
}
