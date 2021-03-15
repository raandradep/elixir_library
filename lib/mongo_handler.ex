defmodule MongoHandler do
  defstruct [:db]
  def create() do
    conf = Application.get_env(:library_mongo, __MODULE__)
    {:ok, pid} = Mongo.start_link(
      url: conf[:url],
      username: conf[:username],
      password: conf[:password],
      database: conf[:database],
      pool_size: conf[:pool_size]
      )
      %MongoHandler{db: pid}
  end

end
