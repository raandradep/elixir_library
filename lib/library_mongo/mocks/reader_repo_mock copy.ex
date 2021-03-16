defmodule ReaderRepoMockImpl do
  @enforce_keys [:pid]
  defstruct [:pid]

  def create(db_handler), do: %ReaderRepoMockImpl{pid: db_handler}
end

defimpl ReaderRepo, for: ReaderRepoMockImpl do
  @spec add(%{:pid => any, optional(any) => any}, nil | maybe_improper_list | map) :: any
  def add(repo, keywords) when repo.pid != nil do
    DbHandler.add(repo.pid, %{dni: keywords[:dni], name: keywords[:name], lastname: keywords[:lastname], email: keywords[:email]})
  end

  def find(repo, filter) when repo.pid != nil do
    DbHandler.find(repo.pid, filter)
  end

  def update(repo, id, keywords) when repo.pid != nil do
    DbHandler.update(repo.pid, id, %{dni: keywords[:dni], name: keywords[:name], lastname: keywords[:lastname], email: keywords[:email]})
  end

  def delete(repo, id) when repo.pid != nil do
    DbHandler.delete(repo.pid, id)
  end
end
