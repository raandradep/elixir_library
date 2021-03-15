
defmodule AuthorRepoMockImpl do
  @enforce_keys [:pid]
  defstruct [:pid]

  def create(db_handler), do: %AuthorRepoMockImpl{pid: db_handler}
end

defimpl AuthorRepo, for: AuthorRepoMockImpl do

  @spec add(%{:pid => any, optional(any) => any}, nil | maybe_improper_list | map) :: any
  def add(repo, keywords) when repo.pid != nil do
    DbHandler.add(repo.pid, %{name: keywords[:name], lastname: keywords[:lastname]})
  end

  def find(repo, filter) when repo.pid != nil do
    DbHandler.find(repo.pid, filter)
  end

  def update(repo, id , keywords) when repo.pid != nil do
    DbHandler.update(repo.pid, id,  %{name: keywords[:name], lastname: keywords[:lastname]})
  end

end
