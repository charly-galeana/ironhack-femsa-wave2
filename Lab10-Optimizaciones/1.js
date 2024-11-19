// Original

function updateList(items) {
    let list = document.getElementById("itemList");
    list.innerHTML = "";
    for (let i = 0; i < items.length; i++) {
      let listItem = document.createElement("li");
      listItem.innerHTML = items[i];
      list.appendChild(listItem);
    }
  }
  
/*
Identificación de problemas.

* Como ya anuncia el comentario, hay una manipulación excesiva de DOM.
La operación appendChild se está realizando una vez para cada elemento
en la lista, lo cual puede resultar costoso.
* Trataremos entonces de hacer un menor número de operaciones DOM y de
no repetir cálculos.
* No es un problema de eficiencia, pero el código original también es poco
legible.
*/

// Refactorización

function updateList(items) {
    let originalList = document.getElementById("itemlist");
    let listOfNewItems = document.createDocumentFragment();

    items.array.forEach(item => {
        const listItem = document.createElement("li");
        listItem.innerHTML = item;
        listOfNewItems.appendChild(listitem);
    });

    originalList.innerHTML = "";
    originalList.appendChild(listOfNewItems);
}

/*
Explicación de cambios y beneficios

En lugar de hacer un append al documento original para cada elemento,
creamos un fragmento temporal en memoria (línea 29). Agregamos los
elementos uno a uno a este fragmento -lo cual es mucho menos costoso 
que agregarlos al documento original. Y al final hacemos UN SOLO llamado
a appendChild del documento original.
*/