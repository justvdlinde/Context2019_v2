using GoogleARCore;
using ServiceLocatorNamespace;
using System;
using UnityEngine;
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
        if(ServiceLocator.Instance.ContainsService<ARManagerService>())
        {
            Destroy(gameObject);
            return;
        }

        ServiceLocator.Instance.AddService(this);
        DontDestroyOnLoad(this);
    }

    public void EnableAR(bool enable)
    {
#if !UNITY_EDITOR
        root.gameObject.SetActive(enable);

        session.enabled = enable;
        sessionController.enabled = enable;

        if (enable)
        {
            backgroundRenderer.m_BackgroundRenderer.mode = ARRenderMode.MaterialAsBackground;
        }

        backgroundRenderer.m_BackgroundRenderer.mode = (enable) ? ARRenderMode.MaterialAsBackground : ARRenderMode.StandardBackground;
#endif
    }
}
