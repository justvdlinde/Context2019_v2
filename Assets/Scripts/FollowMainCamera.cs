using UnityEngine;

public class FollowMainCamera : MonoBehaviour
{
    private Transform target;

    private void Start()
    {
        target = Camera.main.transform;
    }

    private void Update()
    {
        transform.position = target.position;
        transform.rotation = target.rotation;
    }
}
