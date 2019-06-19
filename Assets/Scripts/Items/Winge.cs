using UnityEngine;

public class Winge : MonoBehaviour
{
    [SerializeField] private new Animation animation;

    public void Play()
    {
        animation.Play();
    }
}
