using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class MenuMovementController : MonoBehaviour
{
    [SerializeField] private Transform target;
    [SerializeField] private IntMinMax distanceLimit;
    [SerializeField] private float horizontalRotationSpeed = 200f;
    [SerializeField] private float verticalRotationSpeed = 200f;
    [SerializeField] private IntMinMax verticalRotationLimit;
    [SerializeField] private int zoomRate = 40;
    [SerializeField] private float zoomDampening = 5f;
    [SerializeField] private float minFloorPosition = 5f;

    private float horizontalDegree;
    private float verticalDegree;
    private float currentZoomDistance;
    private float desiredZoomDistance;
    private Quaternion currentRotation;
    private Quaternion desiredRotation;
    private Quaternion rotation;
    private Vector3 position;

    void Start()
    {
        target.SetParent(null);
        Init();
    }

    public void Init()
    {
        float distance = Vector3.Distance(transform.position, target.position);
        currentZoomDistance = distance;
        desiredZoomDistance = distance;

        position = transform.position;
        rotation = transform.rotation;
        currentRotation = transform.rotation;
        desiredRotation = transform.rotation;

        horizontalDegree = Vector3.Angle(Vector3.right, transform.right);
        verticalDegree = Vector3.Angle(Vector3.up, transform.up);
    }

    void LateUpdate()
    {
        Orbit();
        Zoom();

        //if (transform.position.y < minFloorPosition)
        //{
        //    transform.position = new Vector3(transform.position.x, minFloorPosition, transform.position.z);
        //}
    }

    private void Orbit()
    {
        if (Input.GetMouseButton(1))
        {
            horizontalDegree += Input.GetAxis("Mouse X") * horizontalRotationSpeed * 0.02f;
            verticalDegree -= Input.GetAxis("Mouse Y") * verticalRotationSpeed * 0.02f;
            verticalDegree = ClampAngle(verticalDegree, verticalRotationLimit.min, verticalRotationLimit.max);
        }

        desiredRotation = Quaternion.Euler(verticalDegree, horizontalDegree, 0);
        currentRotation = transform.rotation;
        rotation = Quaternion.Lerp(currentRotation, desiredRotation, Time.deltaTime * zoomDampening);
        transform.rotation = rotation;
    }

    private void Zoom()
    {
        desiredZoomDistance -= Input.GetAxis("Mouse ScrollWheel") * Time.deltaTime * zoomRate * Mathf.Abs(desiredZoomDistance);
        desiredZoomDistance = Mathf.Clamp(desiredZoomDistance, distanceLimit.min, distanceLimit.max);
        currentZoomDistance = Mathf.Lerp(currentZoomDistance, desiredZoomDistance, Time.deltaTime * zoomDampening);
        position = target.position - (rotation * Vector3.forward * currentZoomDistance);

        transform.position = position;
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
