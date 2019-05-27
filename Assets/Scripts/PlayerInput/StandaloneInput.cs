using UnityEngine;

public class StandaloneInput : IPlayerInput
{
    private Vector2 positionDelta = Vector2.zero;
    public Vector2 PositionDelta
    {
        get
        {
            positionDelta.x = Input.GetAxis("Mouse X");
            positionDelta.y = Input.GetAxis("Mouse Y");
            return positionDelta;
        }
    }

    public float ZoomDelta
    {
        get
        {
            return Input.GetAxis("Mouse ScrollWheel");
        }
    }

    public bool IsPressed { get { return Input.GetMouseButton(0); } }
}
