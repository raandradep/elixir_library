# LibraryMongo

# BDD: Behavioir Driven Design

Given (Dado una condición o escenario)
When (cuando un ente/usuario cometa una acción)
Then (entonces se hará lo siguiente)

## Library Example

\*Given Un lector quiere prestarse un libro
When no tiene ninguna copia prestada
Then se le presta el libro

- Reader.borrowedBooks
- new borrowedBooksHistory
- Book.numberOfBorrowedCopies
- BookCopy::{readerId, status}

Given Un lector quiere prestarse un libro
When no existe una copia disponible
Then se le deniega el préstamo con un mensaje del motivo

Given Un lector quiere prestarse un libro
When tiene un máximos de 3 libros
Then se le deniega el préstamo con un mensaje del motivo

Given Un lector quiere prestarse un libro
When quiere prestarse más de un copia del mismo libro
Then se le deniega el préstamo con un mensaje del motivo

Given Un lector quiere devolver un libro
When no tiene libros registrados como prestado
Then "se le da mensaje de que no se puede recibir" and "Lanzar alerta a gerencia y desarrollo para validar que no exista errores en el sistema"

\*Given Un lector quiere devolver un libro
When la copia del libro aparece en sistema como prestado a ese lector
Then este se le devuelve y se le habilita al lecto de prestarse un libro

- Reader.borrowedBooks
- borrowedBooksHistory::{status, returnDate}
- Book.numberOfBorrowedCopies
- BookCopy::{readerId, status}

Given Gerencia revisa reportes de libros prestados
When busca los libros más prestados en el último mes
Then Se muestra una lista de libros ordenados por cantidad de préstamos de más a menos

Given Gerencia revisa reportes de libros prestados
When busca los libros menos prestados en el último mes
Then Se muestra una lista de libros ordenados por cantidad de préstamos de menos a más

Given Gerencia revias reportes de libros prestados
when busca qué lectores tienen prestado las copias de un determinado libro
Then se le muestra la lista de usuarios que tienen prestado copias del libro en este instante

Given Gerencia revisa reportes
When quiere ver el detalle de un lector
Then se le muestra la información de dicho lector

//Given Gerencia revisa reportes de libros prestados
//When
//Then Se muestra una lista de libros más pedido pero sin stock

# Designing Entities

```yaml
Book:
  - isbn
  - title
  - description
  - publishedDate
  - numberOfTotalCopies
  -

Author:
  - name
  - lastname

Reader: # User
  - dni
  - name
  - lastName
  - email

BookCopy:
  - bookId
  - readerId?
  - status: BookStatus
```

# Enums

BookStatus: "borrowed", "available"

# Collections / Tables

- authors (...Author)
- books (...Book, authors)
- bookCopies (...BookCopy)
- readers (...Reader, borrowedBooks)
- authorsBooks (authorId, bookId)
- borrowedBooksHistory (copyId, readerId, status, borrowDate, returnDate?)

#

```yaml
Other concepts:
  - book copy
  - borrowed books history
```

