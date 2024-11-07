/*
----1----
Dado que tenemos un JOIN entre Orders y OrderDetails basado en OrderID, crearemos
índices en ambas tablas para la columna OrderId, esto optimizará la ejecución del
JOIN. Por otro lado, sabemos que al escribir JOIN se usa por default INNER JOIN, 
que en este caso específico es el tipo de JOIN adecuado, pues en efecto queremos
recuperar solo las órdenes que cuentan con detalles de orden.

Como también tenemos un filtro por Quantity en OrderDetails, crearemos un índice
sobre el Quantity.

Este query ejecute el filtro 'WHERE OrderDetails.Quantity > 10' luego de haber
realizado la unión con la tabla OrderDetails, lo cual puede ser costoso en tiempo
si en la tabla OrderDetails hay muchas entradas con Quantity menor o igual a 10.
Si ese es el caso, conviene que primero se haga el filtro para tener una tabla temporal
solo con las órdenes con Quantity mayor a 10 y posteriormente hacer el JOIN.
*/

CREATE INDEX idx_orders_orderid ON Orders (OrderID);
CREATE INDEX idx_orderdetails_orderid_quantity ON OrderDetails (OrderID, Quantity);

WITH FilteredDetails AS (
    SELECT OrderID, Quantity, UnitPrice
    FROM OrderDetails
    WHERE Quantity > 10
)
SELECT Orders.OrderID, SUM(FilteredDetails.Quantity * FilteredDetails.UnitPrice) AS TotalPrice
FROM Orders
JOIN FilteredDetails ON Orders.OrderID = FilteredDetails.OrderID
GROUP BY Orders.OrderID;

/*
----2----
La query original ocurre sobre una sola tabla. Sin más contexto de que otro tipo de queries
se ejecutan sobre esta tabla, y considerando que nuestra consulta solo filtra por Ciudad, 
podríamos agregar un índice sobre la columna City. Sin embargo, considerando que esta query 
pide ordenar por CustomerName, si creamos un índice compuesto sobre (City, CustomerName) la ejecución
de la query podría evitar tener que ordenar y recuperar las filas ordenadas diréctamente de 
los índices. La query permanece sin cambios, solo añadimos el comendao para la creación del índice.
Optaremos por esta opción dado solo el contexto de la query proporcionada, pero 
también sería viable crear un índice que solo cubriera la columna City. 
*/

CREATE INDEX idx_city_customername ON Customers (City, CustomerName);
SELECT CustomerName FROM Customers WHERE City = 'London' ORDER BY CustomerName;

/*
Si además se ejecutaran queries frecuentes que solo filtran por ciudad, sin ordenar por 
customer name, es viable crear un índice solo para la columna de ciudad
*/

CREATE INDEX idx_city ON Customers (City);

