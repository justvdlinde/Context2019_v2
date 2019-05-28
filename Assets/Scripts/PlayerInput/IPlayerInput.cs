using UnityEngine;

public interface IPlayerInput 
{
    bool IsPressed { get; }
    Vector2 PositionDelta { get; }
    float ZoomDelta { get; }
}
