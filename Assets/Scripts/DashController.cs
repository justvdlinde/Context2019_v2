using UnityEngine;
using UnityEngine.UI;

public class DashController : MonoBehaviour
{
    [SerializeField] private Button dashButton;
    [SerializeField] private float movementSpeed = 1;

    private void OnEnable()
    {
        dashButton.onClick.AddListener(Dash);
    }

    private void OnDisable()
    {
        dashButton.onClick.RemoveListener(Dash);
    }

    public void Dash()
    {
        Camera.main.transform.position += Camera.main.transform.forward * movementSpeed * Time.deltaTime;
    }
}
