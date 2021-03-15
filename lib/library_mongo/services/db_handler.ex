defprotocol DbHandler do
  def add(repo, map)
  def find(repo, criteria \\ %{})
end
