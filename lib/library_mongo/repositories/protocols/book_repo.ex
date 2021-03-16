defprotocol BookRepo do
  def add(repo, map)

  def find(repo, criteria \\ %{})

  def update(repo, id, map)

  def delete(repo, id)
end
