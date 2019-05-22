using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class MenuMovementController : MonoBehaviour
{
    [SerializeField] private float rotateSpeed;
    [SerializeField] private float rotateSpeedMobile;

    private void Update()
    {
        if (Input.GetMouseButton(0))
        {
            //if(EventSystem.current.IsPointerOverGameObject()) { return; }

            float horizontalDelta = 0;
            float verticalDelta = 0;
            float rotateSpeed = this.rotateSpeed;

            // TODO: refactor this to be cleaner
            if (Input.touchCount > 0)
            {
                horizontalDelta = Input.touches[0].deltaPosition.x;
                verticalDelta = Input.touches[0].deltaPosition.y;
                rotateSpeed = rotateSpeedMobile;
            }
            else
            {
                horizontalDelta = Input.GetAxis("Mouse X");
                verticalDelta = Input.GetAxis("Mouse Y");
            }

            //Quaternion extraRotation = Quaternion.AngleAxis(-horizontalDelta / transform.localScale.x * rotateSpeed, Vector3.up)
            //                            * Quaternion.AngleAxis(verticalDelta / transform.localScale.y * rotateSpeed, Vector3.right);

            //transform.rotation = transform.transform.rotation * extraRotation;
            transform.RotateAround(transform.position, Vector3.up, horizontalDelta);
        }
    }
}
