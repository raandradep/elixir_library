defmodule AuthorMock do
  defstruct [:pid]

  use GenServer

  def create() do
    {:ok, pid} = GenServer.start_link(__MODULE__, {0, %{}})
    %AuthorMock{pid: pid}
  end

  @impl true
  def init(state), do: {:ok, state}

  @impl true
  def handle_call({:add, %{name: name, lastname: lastname}}, _, {author_id, authors}) do
    new_id = author_id + 1
    new_user = %Author{_id: new_id, name: name, lastname: lastname}
    authors = Map.put(authors, new_id, new_user)
    state = {new_id, authors}
    {:reply, new_user, state}
  end

  @impl true
  def handle_call({:find, id}, _, {author_id, authors} = state) do
    if author_id < id or id < 1 do
      {:reply, nil, state}
    else
      {:reply, authors[id], state}
    end
  end

  @impl true
  def handle_call(
        {:update, id, %{name: name, lastname: lastname}},
        _,
        {author_id, authors} = state
      ) do
    if author_id < id or id < 1 do
      {:reply, nil, state}
    else
      new_id = id
      new_user = %Author{_id: new_id, name: name, lastname: lastname}
      authors = Map.put(authors, new_id, new_user)
      state = {new_id, authors}
      {:reply, new_user, state}
    end
  end

  @impl true
  def handle_call({:delete, id}, _, {author_id, authors} = state) do
    if author_id < id or id < 1 do
      {:reply, nil, state}
    else
      authors = Enum.filter(authors, fn {_, map} -> map._id != id end)
      state = {0, authors}
      {:reply, authors, state}
    end
  end
end

defimpl DbHandler, for: AuthorMock do
  def add(handler, %{name: _, lastname: _} = map) do
    GenServer.call(handler.pid, {:add, map})
  end

  def find(handler, filter) do
    GenServer.call(handler.pid, {:find, filter})
  end

  def update(handler, id, %{name: _, lastname: _} = map) do
    GenServer.call(handler.pid, {:update, id, map})
  end

  def delete(handler, id) do
    GenServer.call(handler.pid, {:delete, id})
  end
end
