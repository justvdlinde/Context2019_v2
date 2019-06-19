using UnityEngine;
using UnityEngine.UI;

public class DashController : MonoBehaviour
{
    [SerializeField] private Button dashButton;
    [SerializeField] private float movementSpeed = 1;

    private ARManagerService arManager;

    private void Start()
    {
        arManager = ServiceLocatorNamespace.ServiceLocator.Instance.Get<ARManagerService>() as ARManagerService;
    }

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
        Vector3 newPos = Camera.main.transform.position + Camera.main.transform.forward * movementSpeed * Time.deltaTime;
        newPos.y = Camera.main.transform.position.y;
#if !UNITY_EDITOR
        arManager.MovePosition(newPos);
#else
        Camera.main.transform.position = newPos;
#endif

    }
}
