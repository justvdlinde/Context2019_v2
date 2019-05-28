using ServiceLocatorNamespace;
using System;
using UnityEngine;

public class SceneManagerService : MonoBehaviour, IService
{
    [SerializeField] private GameObject root;

    private void Awake()
    {
        if (ServiceLocator.Instance.ContainsService<ARManagerService>())
        {
            Destroy(gameObject);
            return;
        }

        ServiceLocator.Instance.AddService(this);
        DontDestroyOnLoad(this);
        ShowLoadingbar(false);
    }

    public void LoadScene(string scene, Action onDone = null)
    {
        ShowLoadingbar(true);
        onDone += () => ShowLoadingbar(false);
        StartCoroutine(SceneManagerUtility.LoadScene(scene, onDone));
    }

    public void ShowLoadingbar(bool show)
    {
        enabled = show;
        root.SetActive(show);
    }
}
