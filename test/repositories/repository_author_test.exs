defmodule RepositoryAuthorTest do
  use ExUnit.Case

  test "AuthorRepoImpl.pid is nil" do
    repo = %AuthorRepoMockImpl{pid: nil}
    assert_raise FunctionClauseError, fn -> AuthorRepo.add(repo, %{}) end
    assert_raise FunctionClauseError, fn -> AuthorRepo.find(repo,nil) end
  end

  test "AuthorRepoImpl.add" do
     db_handler = AuthorMock.create()
     repo = AuthorRepoMockImpl.create(db_handler)

     authormap = %{name: "Juan", lastname: "Perez"}
     author = AuthorRepo.add(repo, authormap)
     assert author._id == 1

     authormap = %{name: "Miguel", lastname: "Perez"}
     author = AuthorRepo.add(repo, authormap)
     assert author._id == 2
  end


  test "AuthorRepoImpl.find" do
    db_handler = AuthorMock.create()
    repo = AuthorRepoMockImpl.create(db_handler)

    AuthorRepo.add(repo, %{name: "Juan", lastname: "Perez"})
    AuthorRepo.add(repo, %{name: "Miguel", lastname: "Calero"})
    AuthorRepo.add(repo, %{name: "Pepe", lastname: "Hernandez"})

    author = AuthorRepo.find(repo,  3)
    assert author.name == "Pepe"
 end


 test "AuthorRepoImpl.update" do
  db_handler = AuthorMock.create()
  repo = AuthorRepoMockImpl.create(db_handler)

  AuthorRepo.add(repo, %{name: "Juan", lastname: "Perez"})
  AuthorRepo.add(repo, %{name: "Miguel", lastname: "Calero"})
  AuthorRepo.add(repo, %{name: "Pepe", lastname: "Hernandez"})

  AuthorRepo.update(repo,  2, %{name: "Juanito", lastname: "Velez"})

  author = AuthorRepo.find(repo,  2)
  assert author.name == "Juanito"
  assert author.lastname == "Velez"

end

end
