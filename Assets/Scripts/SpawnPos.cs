using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SpawnPos : MonoBehaviour
{
    [SerializeField] private Button calibrateButton;
    private Transform player;

    private float playerHeight = .7f;
    private void OnEnable()
    {
        calibrateButton.onClick.AddListener(() => CalculateHeight());
        player = GameObject.Find("ARCore Device").transform;
    }

    private void OnDisable()
    {
        calibrateButton.onClick.RemoveAllListeners();   
    }
    void CalculateHeight()
    {
        Debug.Log("Calibrating heigt");
        RaycastHit hit = new RaycastHit();
        if (Physics.Raycast(player.transform.position, -Vector3.up, out hit))
        {
            var distanceToGround = hit.distance;
            SetHeight(playerHeight - distanceToGround);
        }
    }

    void SetHeight(float playerHeight)
    {
        player.transform.Translate(player.transform.position.x, player.transform.position.y  - player.transform.position.y + playerHeight, player.transform.position.z);
    }
}
