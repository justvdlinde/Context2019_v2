using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class MenuMovementController : MonoBehaviour
{
    [SerializeField] private Transform camTransform;
    [SerializeField] private Transform target;
    [SerializeField] private IntMinMax distanceLimit;
    [SerializeField] private float horizontalRotationSpeed = 200f;
    [SerializeField] private float verticalRotationSpeed = 200f;
    [SerializeField] private IntMinMax verticalRotationLimit;
    [SerializeField] private int zoomRate = 40;
    [SerializeField] private float zoomDampening = 5f;
    [SerializeField] private float minVerticalDegree = 2f;

    private float horizontalDegree;
    private float verticalDegree;
    private float currentZoomDistance;
    private float desiredZoomDistance;
    private Quaternion currentRotation;
    private Quaternion desiredRotation;
    private Quaternion rotation;
    private Vector3 position;

    private IPlayerInput playerInput;

    void Start()
    {
        playerInput = (ServiceLocatorNamespace.ServiceLocator.Instance.Get<PlayerInputService>() as PlayerInputService).Input;
        Init();
    }

    public void Init()
    {
        float distance = Vector3.Distance(camTransform.position, target.position);
        currentZoomDistance = distance;
        desiredZoomDistance = distance;

        position = camTransform.position;
        rotation = camTransform.rotation;
        currentRotation = camTransform.rotation;
        desiredRotation = camTransform.rotation;

        horizontalDegree = Vector3.Angle(Vector3.right, camTransform.right);
        verticalDegree = Vector3.Angle(Vector3.up, camTransform.up);
    }

    private void LateUpdate()
    {
        Orbit();
        Zoom();
    }

    private void Orbit()
    {
        if (playerInput.IsPressed)
        {
            horizontalDegree += playerInput.PositionDelta.x * horizontalRotationSpeed * 0.02f;
            verticalDegree -= playerInput.PositionDelta.y * verticalRotationSpeed * 0.02f;
            verticalDegree = ClampAngle(verticalDegree, verticalRotationLimit.min, verticalRotationLimit.max);
            verticalDegree = Mathf.Clamp(verticalDegree, minVerticalDegree, 360);
        }

        desiredRotation = Quaternion.Euler(verticalDegree, horizontalDegree, 0);
        currentRotation = camTransform.rotation;
        rotation = Quaternion.Lerp(currentRotation, desiredRotation, Time.deltaTime * zoomDampening);

        camTransform.rotation = rotation;
    }

    private void Zoom()
    {
        desiredZoomDistance -= playerInput.ZoomDelta * Time.deltaTime * zoomRate * Mathf.Abs(desiredZoomDistance);
        desiredZoomDistance = Mathf.Clamp(desiredZoomDistance, distanceLimit.min, distanceLimit.max);
        currentZoomDistance = Mathf.Lerp(currentZoomDistance, desiredZoomDistance, Time.deltaTime * zoomDampening);
        position = target.position - (rotation * Vector3.forward * currentZoomDistance);

        camTransform.position = position;
    }

    private static float ClampAngle(float angle, float min, float max)
    {
        if (angle < -360)
            angle += 360;
        if (angle > 360)
            angle -= 360;
        return Mathf.Clamp(angle, min, max);
    }
}
