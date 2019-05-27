using UnityEngine;

public class MobileInput : IPlayerInput
{
    private Vector2 positionDelta = Vector2.zero;
    public Vector2 PositionDelta
    {
        get
        {
            positionDelta.x = Input.touches[0].deltaPosition.x * Time.deltaTime;
            positionDelta.y = Input.touches[0].deltaPosition.y * Time.deltaTime;
            return positionDelta;
        }
    }

    public float ZoomDelta
    {
        get
        {
            float zoomDelta = 0;
            if (Input.touchCount == 2)
            {
                Touch touchZero = Input.GetTouch(0);
                Touch touchOne = Input.GetTouch(1);

                Vector2 touchZeroPrevPos = touchZero.position - touchZero.deltaPosition;
                Vector2 touchOnePrevPos = touchOne.position - touchOne.deltaPosition;

                float prevMagnitude = (touchZeroPrevPos - touchOnePrevPos).magnitude;
                float currentMagnitude = (touchZero.position - touchOne.position).magnitude;
                float difference = currentMagnitude - prevMagnitude;

                zoomDelta = difference * Time.deltaTime;
            }

            return zoomDelta;
        }
    }

    public bool IsPressed { get { return Input.touchCount > 0; } }
}
