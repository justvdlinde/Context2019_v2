using ServiceLocatorNamespace;

public class PlayerInputService : IService
{
    public IPlayerInput Input;

    public PlayerInputService()
    {
        Input = InputFactory();   
    }

    public IPlayerInput InputFactory()
    {
#if UNITY_EDITOR || UNITY_STANDALONE
        return new StandaloneInput();
#else
        return new MobileInput();
#endif
    }
}
