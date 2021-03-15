defmodule AuthorRepoImpl do
  @enforce_keys [:pid]
  defstruct [:pid]

  def create(db_handler) do
    %AuthorRepoImpl{pid: db_handler.db}
  end
end

defimpl AuthorRepo, for: AuthorRepoImpl do

  @collection "authors"


  def add(repo,  map) do
    repo.pid |> Mongo.insert_one(@collection, map)
  end

  def find(repo, criteria \\ %{}) do
    repo.pid |> Mongo.find(@collection, criteria) |> Enum.to_list()
  end

  def find_by_id(repo, id) do
    repo.pid |> Mongo.find_one(@collection, %{"_id" => id})
  end


  def update(repo, id,  %Author{} = map) do
    repo.pid |> Mongo.find_one_and_update(@collection, %{"_id" => id} , map)
  end

  def delete(repo, id) do
    repo.pid |> Mongo.find_one_and_delete(@collection, %{"_id" => id})
  end

end
