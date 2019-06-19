using System;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(AudioSource))]
public class SidebarUI : MonoBehaviour
{
    [SerializeField] private Button openSidebarButton;
    [SerializeField] private Button closeSidebarButton;
    [SerializeField] private Animator animator;
    [SerializeField] private Transform sidebar;
    [SerializeField] private ToggleGroup toggleGroup;

    [Header("Audio")]
    [SerializeField] private AudioClip sidebarOpen;
    [SerializeField] private AudioClip sidebarClose;

    public const string ANIMATOR_OPEN_TRIGGER = "Open";
    public const string ANIMATOR_CLOSE_TRIGGER = "Close";

    public Action OpenEvent;
    public Action CloseEvent;

    private AudioSource audioSource;

    private void OnValidate()
    {
        audioSource = GetComponent<AudioSource>();
    }

    protected virtual void Awake()
    {
        animator.enabled = false;
        sidebar.gameObject.SetActive(false);
    }

    protected virtual void OnEnable()
    {
        openSidebarButton.onClick.AddListener(OnOpenButtonClickedEvent);
        closeSidebarButton.onClick.AddListener(OnCloseButtonClickedEvent);
    }

    protected virtual void OnDisable()
    {
        openSidebarButton.onClick.RemoveListener(OnOpenButtonClickedEvent);
        closeSidebarButton.onClick.RemoveListener(OnCloseButtonClickedEvent);
    }

    private void OnCloseButtonClickedEvent()
    {
        Close();
    }

    private void OnOpenButtonClickedEvent()
    {
        Open();
    }

    public void Close()
    {
        audioSource.PlayOneShot(sidebarClose);
        animator.enabled = true;
        animator.SetTrigger(ANIMATOR_CLOSE_TRIGGER);

        CloseEvent?.Invoke();
    }

    public void Open()
    {
        audioSource.PlayOneShot(sidebarOpen);
        animator.enabled = true;
        animator.SetTrigger(ANIMATOR_OPEN_TRIGGER);

        OpenEvent?.Invoke();
    }
}
