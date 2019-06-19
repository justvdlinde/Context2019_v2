using GoogleARCore;
using ServiceLocatorNamespace;
using System;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.XR;

public class ARManagerService : MonoBehaviour, IService
{
    public Action<TrackedImageObject> NewImageTrackedEvent;

    [SerializeField] private GameObject root;
    [SerializeField] private ARCoreSession session;
    [SerializeField] private ImageTrackingController sessionController;
    [SerializeField] private ARCoreBackgroundRenderer backgroundRenderer;

    [SerializeField] private TrackedImageScene[] trackableScenes;
    public TrackedImageScene[] TrackableScenes => trackableScenes;

    private void Awake()
    {
        if (ServiceLocator.Instance.ContainsService<ARManagerService>())
        {
            Destroy(gameObject);
            return;
        }

        ServiceLocator.Instance.AddService(this);
        DontDestroyOnLoad(this);
    }

    private void OnEnable()
    {
        SceneManager.activeSceneChanged += OnSceneChangeEvent;
    }

    private void OnDisable()
    {
        SceneManager.activeSceneChanged -= OnSceneChangeEvent;
    }

    private void OnSceneChangeEvent(Scene from, Scene to)
    {
#if !UNITY_EDITOR
        EnableBackgroundRenderer(false);
#endif
    }

    public void EnableAR(bool enable)
    {
#if !UNITY_EDITOR
        root.gameObject.SetActive(enable);

        session.enabled = enable;
        sessionController.enabled = enable;

        EnableBackgroundRenderer(enable);
#endif
    }

    public void EnableBackgroundRenderer(bool enable)
    {
        backgroundRenderer.m_BackgroundRenderer.mode = (enable) ? ARRenderMode.MaterialAsBackground : ARRenderMode.StandardBackground;
    }

    public void MovePosition(Vector3 newPosition)
    {
        session.gameObject.transform.position = newPosition;
    }
}
