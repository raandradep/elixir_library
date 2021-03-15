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

     author = AuthorRepo.find(repo,  2)
     assert author._id == 2

  end

end
