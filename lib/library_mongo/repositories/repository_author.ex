defprotocol LibraryMongo.AuthorRepo do
  #def insert_all(list)
  def add(map)
  def get(criteria \\ %{})
  #def find_by_id(id)
  #def update_all(filter, list)
  #def update(id, map)
  #def delete(id)
end

defimpl LibraryMongo.AuthorRepo, for: LibraryMongo.AuthorRepoImpl do

  @collection "authors"

  def add(map) do
    :mongo |> Mongo.insert_one(@collection,map)
  end

  def get(criteria) do
    :mongo |> Mongo.find(@collection, criteria) |> Enum.to_list()
  end


end
