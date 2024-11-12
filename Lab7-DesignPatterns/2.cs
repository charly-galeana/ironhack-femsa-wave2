// Superclase para todos los elementos de UI
public interface IUIElement
{
    void Render();
}

// Algunos objetos específicos que implementan la clase IUIElement

public class Button : IUIElement
{
    public void Render()
    {
        Console.WriteLine("Button!");
    }
}

public class TextField : IUIElement
{
    public void Render()
    {
        Console.WriteLine("Text Field!");
    }
}

// Clase factory para decidir el elemento dependiendo del
// tipo de acción del usuario
public class UIElementFactory
{
    public IUIElement CreateUIElement(string userActionType)
    {
        return userActionType switch
        {
            "Button" => new Button(),
            "TextField" => new TextField(),
            ...
            ...
        };
    }
}