using UnityEngine;

public class Rotate : MonoBehaviour
{
    [SerializeField] private Vector3 direction;
    [SerializeField] private float speed;

    private void Update()
    {
        transform.Rotate(direction * speed * Time.deltaTime);
    }
}
