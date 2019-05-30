using ServiceLocatorNamespace;
using UnityEngine;

public class FootStepAudioService : IService
{
    public AudioClip[] RightFootAudioClips => rightFootAudioClips.Clips;
    private AudioCollection rightFootAudioClips;

    public AudioClip[] LeftFootAudioClips => leftFootAudioClips.Clips;
    private AudioCollection leftFootAudioClips;

    private const string RIGHT_FOOTSTEP_COLLECTION = "Footsteps Right";
    private const string LEFT_FOOTSTEP_COLLECTION = "Footsteps Left";

    public FootStepAudioService()
    {
        rightFootAudioClips = Resources.Load<AudioCollection>(RIGHT_FOOTSTEP_COLLECTION);
        leftFootAudioClips = Resources.Load<AudioCollection>(LEFT_FOOTSTEP_COLLECTION);
    }
}
