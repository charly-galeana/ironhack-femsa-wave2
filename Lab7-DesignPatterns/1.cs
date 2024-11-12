public sealed class ConfigurationManager
{
    // Una única instancia que se inicializa una única vez
    private static ConfigurationManager _instance;

    // Objeto que guarda los settings
    private Settings _settings;

    // Constructor privado 
    private ConfigurationManager()
    {
        // Inicializar los settings
        _settings = ...
    }

    // Si no existe una instancia se crea una nueva, de lo contrario
    // se devuelve la existente
    public static ConfigurationManager Instance
    {
        get
        {
            if (_instance == null)
            {
                _instance = new ConfigurationManager();
            }
            return _instance;
        }
    }
}
