using UnityEngine;

public enum Foot
{
    Left = 0,
    Right = 1
}

[RequireComponent(typeof(AudioSource))]
public class FootStepSoundController : MonoBehaviour
{
    public Foot Foot => foot;
    [SerializeField] private Foot foot;

    [SerializeField] private float rayLength;
    [SerializeField] private LayerMask layerMask;
    [SerializeField] private FloatMinMax pitchMinMax;
    [SerializeField] private FloatMinMax volumeOffset;

    [SerializeField, HideInInspector] private AudioSource audioSource;

    private RaycastHit hit;
    private Ray ray;
    private AudioClip[] audioClips;
    private FootStepAudioService audioService;

    private void OnValidate()
    {
        audioSource = GetComponent<AudioSource>();
    }

    private void Start()
    {
        audioService = ServiceLocatorNamespace.ServiceLocator.Instance.Get<FootStepAudioService>() as FootStepAudioService;
        audioClips = (foot == Foot.Left) ? audioService.LeftFootAudioClips : audioService.RightFootAudioClips;
    }

    public void CheckForFloor(float volume)
    {
        ray = new Ray(transform.position, Vector3.down);
        if (Physics.Raycast(ray, out hit, rayLength, layerMask))
        {
            PlayAudioClip(volume);
        }
    }
    
    private void PlayAudioClip(float baseVolume)
    {
        audioSource.volume = baseVolume + volumeOffset.GetRandom();
        audioSource.pitch = pitchMinMax.GetRandom();
        audioSource.PlayOneShot(audioClips.GetRandom());
    }
    
    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawRay(transform.position, Vector3.down * rayLength);
    }
}
