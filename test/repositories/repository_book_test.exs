defmodule RepositoryBookTest do
  use ExUnit.Case

  test "BookRepoImpl.pid is nil" do
    repo = %BookRepoMockImpl{pid: nil}
    assert_raise FunctionClauseError, fn -> BookRepo.add(repo, %{}) end
    assert_raise FunctionClauseError, fn -> BookRepo.find(repo, nil) end
  end

  test "BookRepoImpl.add" do
    db_handler = BookMock.create()
    repo = BookRepoMockImpl.create(db_handler)
    book1 = BookRepo.add(repo, %{isbn: "SBN656565", title: "Libro 1", description: "Desc Libro 1", publishedDate: ~U[2021-03-16 07:00:18.965Z], number_total_copies: 2})
    book2 = BookRepo.add(repo, %{isbn: "SBN656566", title: "Libro 2", description: "Desc Libro 2", publishedDate: ~U[2021-03-16 07:00:18.965Z], number_total_copies: 2})
    assert book1._id == 1
    assert book2._id == 2
  end

  test "BookRepoImpl.find" do
    db_handler = BookMock.create()
    repo = BookRepoMockImpl.create(db_handler)

    BookRepo.add(repo, %{isbn: "SBN656565", title: "Libro 1", description: "Desc Libro 1", publishedDate: ~U[2021-03-16 07:00:18.965Z], number_total_copies: 2})
    BookRepo.add(repo, %{isbn: "SBN656566", title: "Libro 2", description: "Desc Libro 2", publishedDate: ~U[2021-03-16 07:00:18.965Z], number_total_copies: 2})
    BookRepo.add(repo, %{isbn: "SBN656567", title: "Libro 3", description: "Desc Libro 3", publishedDate: ~U[2021-03-16 07:00:18.965Z], number_total_copies: 2})
    BookRepo.add(repo, %{isbn: "SBN656568", title: "Libro 4", description: "Desc Libro 4", publishedDate: ~U[2021-03-16 07:00:18.965Z], number_total_copies: 2})
    book = BookRepo.find(repo, 3)
    assert book.isbn == "SBN656567"
    assert book.title == "Libro 3"
  end

  test "BookRepoImpl.update" do
    db_handler = BookMock.create()
    repo = BookRepoMockImpl.create(db_handler)

    BookRepo.add(repo, %{isbn: "SBN656565", title: "Libro 1", description: "Desc Libro 1", publishedDate: ~U[2021-03-16 07:00:18.965Z], number_total_copies: 2})
    BookRepo.add(repo, %{isbn: "SBN656566", title: "Libro 2", description: "Desc Libro 2", publishedDate: ~U[2021-03-16 07:00:18.965Z], number_total_copies: 2})
    BookRepo.add(repo, %{isbn: "SBN656567", title: "Libro 3", description: "Desc Libro 3", publishedDate: ~U[2021-03-16 07:00:18.965Z], number_total_copies: 2})
    BookRepo.add(repo, %{isbn: "SBN656568", title: "Libro 4", description: "Desc Libro 4", publishedDate: ~U[2021-03-16 07:00:18.965Z], number_total_copies: 2})

    BookRepo.update(repo, 4, %{isbn: "SBN656569", title: "Libro 5", description: "Desc Libro 5", publishedDate: ~U[2021-03-16 07:00:18.965Z], number_total_copies: 2})

    book = BookRepo.find(repo, 4)
    assert book.isbn == "SBN656569"
    assert book.title == "Libro 5"

  end

  test "BookRepoImpl.delete" do
    db_handler = BookMock.create()
    repo = BookRepoMockImpl.create(db_handler)

    BookRepo.add(repo, %{isbn: "SBN656565", title: "Libro 1", description: "Desc Libro 1", publishedDate: ~U[2021-03-16 07:00:18.965Z], number_total_copies: 2})
    BookRepo.add(repo, %{isbn: "SBN656566", title: "Libro 2", description: "Desc Libro 2", publishedDate: ~U[2021-03-16 07:00:18.965Z], number_total_copies: 2})
    BookRepo.add(repo, %{isbn: "SBN656567", title: "Libro 3", description: "Desc Libro 3", publishedDate: ~U[2021-03-16 07:00:18.965Z], number_total_copies: 2})
    BookRepo.add(repo, %{isbn: "SBN656568", title: "Libro 4", description: "Desc Libro 4", publishedDate: ~U[2021-03-16 07:00:18.965Z], number_total_copies: 2})

    BookRepo.delete(repo, 4)
    book = BookRepo.find(repo, 4)
    assert book == nil
  end
end
