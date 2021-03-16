defmodule RepositoryReaderTest do
  use ExUnit.Case

  test "ReaderRepoImpl.pid is nil" do
    repo = %ReaderRepoMockImpl{pid: nil}
    assert_raise FunctionClauseError, fn -> ReaderRepo.add(repo, %{}) end
    assert_raise FunctionClauseError, fn -> ReaderRepo.find(repo, nil) end
  end

  test "ReaderRepoImpl.add" do
    db_handler = ReaderMock.create()
    repo = ReaderRepoMockImpl.create(db_handler)
    author1 = ReaderRepo.add(repo, %{dni: 656565, name: "Juan", lastname: "Perez", email: "jperez@email.com"})
    author2 = ReaderRepo.add(repo, %{dni: 785646, name: "Miguel", lastname: "Velez", email: "mvelez@email.com"})
    assert author1._id == 1
    assert author2._id == 2
  end

  test "ReaderRepoImpl.find" do
    db_handler = ReaderMock.create()
    repo = ReaderRepoMockImpl.create(db_handler)

    ReaderRepo.add(repo, %{dni: 656565, name: "Juan", lastname: "Perez", email: "jperez@email.com"})
    ReaderRepo.add(repo, %{dni: 767565, name: "Pedro", lastname: "Juarez", email: "pjuarez@email.com"})
    ReaderRepo.add(repo, %{dni: 867546, name: "Diego", lastname: "Acosta", email: "dacosta@email.com"})
    ReaderRepo.add(repo, %{dni: 465655, name: "Julia", lastname: "Barona", email: "dacosta@email.com"})
    author = ReaderRepo.find(repo, 4)
    assert author.dni == 465655
    assert author.name == "Julia"
  end

  test "ReaderRepoImpl.update" do
    db_handler = ReaderMock.create()
    repo = ReaderRepoMockImpl.create(db_handler)

    ReaderRepo.add(repo, %{dni: 656565, name: "Juan", lastname: "Perez", email: "jperez@email.com"})
    ReaderRepo.add(repo, %{dni: 767565, name: "Pedro", lastname: "Juarez", email: "pjuarez@email.com"})
    ReaderRepo.add(repo, %{dni: 867546, name: "Diego", lastname: "Acosta", email: "dacosta@email.com"})
    ReaderRepo.add(repo, %{dni: 465655, name: "Julia", lastname: "Barona", email: "dacosta@email.com"})

    ReaderRepo.update(repo, 2, %{dni: 5466576, name: "Carmen", lastname: "Villalobos", email: "cvillalobos@email.com"})

    author = ReaderRepo.find(repo, 2)
    assert author.dni == 5466576
    assert author.name == "Carmen"
    assert author.lastname == "Villalobos"
  end

  test "ReaderRepoImpl.delete" do
    db_handler = ReaderMock.create()
    repo = ReaderRepoMockImpl.create(db_handler)

    ReaderRepo.add(repo, %{dni: 656565, name: "Juan", lastname: "Perez", email: "jperez@email.com"})
    ReaderRepo.add(repo, %{dni: 767565, name: "Pedro", lastname: "Juarez", email: "pjuarez@email.com"})
    ReaderRepo.add(repo, %{dni: 867546, name: "Diego", lastname: "Acosta", email: "dacosta@email.com"})
    ReaderRepo.add(repo, %{dni: 465655, name: "Julia", lastname: "Barona", email: "dacosta@email.com"})

    ReaderRepo.delete(repo, 3)
    author = ReaderRepo.find(repo, 3)
    assert author == nil
  end
end
