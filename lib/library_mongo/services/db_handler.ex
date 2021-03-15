defprotocol DbHandler do
  def add(repo, map)
  def find(repo, criteria \\ %{})
  def update(repo, id, map)
end
