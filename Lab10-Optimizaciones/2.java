// Original
// Redundant database queries
public class ProductLoader {
    public List<Product> loadProducts() {
        List<Product> products = new ArrayList<>();
        for (int id = 1; id <= 100; id++) {
            products.add(database.getProductById(id));
        }
        return products;
    }
}

/*
Identificación de problemas

Es claro que para cada elemento que se quiere agregar se hace un query
separado a la base de datos. Esto es excesivamente costoso y poco escalable,
pues cada nuevo vuelve a repetir las faces de setup y ejecución.
Intentaremos reducir entonces el número de queries diferentes ejecutadas.
*/

// Refactorización

public class ProductLoader {
    public List<Product> loadProductsByRange(int firstId, int lastId) {
        return database.getProductsByRange(firstId, lastId);
    }
}

public class DataBase {
    public List<Product> getProductsByRange(int firstId, int lastId) {
        String q = "SELECT xyz FROM products WHERE id BETWEEN ? AND ?"
        return executeQuery(query, firstId, lastId);
    }
}

/*

Explicación de cambios.

En primer lugar hemos hecho que la función sea genérica. La original
cargaba siempre los products con ID entre 1 y 100. Con esta nueva función
esa lógica se puede reusar para recuperar productos en un rango cualquiera de 
IDs. 

En segundo lugar, agregamos una función getProductsByRange a la clase
que implementa la conexión con la DB. Esta función requiere ejecutar una
única query para recuperar productos en un rango. Nótese que esta función 
debe indicar que columnas son las que se quieren recuperar, en la 
práctica en lugar de xyz se escribiríam los atributos de interés.

La nueva función loadProducts llamaría a la función nueva de la base de datos,
de manera que solo se hace un query para recuperar todos los productos
en un rango continuo de IDs.
*/