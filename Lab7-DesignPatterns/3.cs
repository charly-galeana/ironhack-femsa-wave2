public class Subject
{
    // Lista de los observadores
    private readonly List<IObserver> _observers = new();
    private string _state;

    // Registra un observador
    public void RegisterObserver(IObserver observer)
    {
        _observers.Add(observer);
    }

    // Borrar un observador
    public void UnregisterObserver(IObserver observer)
    {
        _observers.Remove(observer);
    }

    public string State
    {
        get => _state;
        set
        {
            _state = value;
            NotifyObservers();
        }
    }

    // Se notifica a todos los observadores de un cambio
    private void NotifyObservers()
    {
        foreach (var observer in _observers)
        {
            observer.Update(_state);
        }
    }
}

// Implementamos una clase observador
public interface IObserver
{
    void Update(string state);
}

// Un par de clases que 'observan' los cambios en subject
public class Observer1 : IObserver
{
    public void Update(string state)
    {
        Console.WriteLine($"Observer1: State changed to {state}");
    }
}

public class Observer2 : IObserver
{
    public void Update(string state)
    {
        Console.WriteLine($"Observer2: State recorded as {state}");
    }
}

// En la aplicación principal se registrarían los observadores para una instancia de
// Subject

Observer1 obs1 = new Observer1();
Observer2 obs2 = new Observer2();

subject.RegisterObserver(obs1);
subject.RegisterObserver(obs2);