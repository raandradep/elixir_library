defmodule BookRepoMockImpl do
  @enforce_keys [:pid]
  defstruct [:pid]

  def create(db_handler), do: %BookRepoMockImpl{pid: db_handler}
end

defimpl BookRepo, for: BookRepoMockImpl do
  @spec add(%{:pid => any, optional(any) => any}, nil | maybe_improper_list | map) :: any
  def add(repo, keywords) when repo.pid != nil do
    DbHandler.add(repo.pid, %{isbn: keywords[:isbn], title: keywords[:title], description: keywords[:description], publishedDate: keywords[:publishedDate], number_total_copies: keywords[:number_total_copies]})
  end

  def find(repo, filter) when repo.pid != nil do
    DbHandler.find(repo.pid, filter)
  end

  def update(repo, id, keywords) when repo.pid != nil do
    DbHandler.update(repo.pid, id, %{isbn: keywords[:isbn], title: keywords[:title], description: keywords[:description], publishedDate: keywords[:publishedDate], number_total_copies: keywords[:number_total_copies]})
  end

  def delete(repo, id) when repo.pid != nil do
    DbHandler.delete(repo.pid, id)
  end


end
