defmodule ReaderMock do
  defstruct [:pid]

  use GenServer

  def create() do
    {:ok, pid} = GenServer.start_link(__MODULE__, {0, %{}})
    %ReaderMock{pid: pid}
  end

  @impl true
  def init(state), do: {:ok, state}

  @impl true
  def handle_call({:add, %{dni: dni, name: name, lastname: lastname, email: email}}, _, {reader_id, readers}) do
    new_id = reader_id + 1
    new_reader = %Reader{_id: new_id, dni: dni, name: name, lastname: lastname, email: email}
    readers = Map.put(readers, new_id, new_reader)
    state = {new_id, readers}
    {:reply, new_reader, state}
  end

  @impl true
  def handle_call({:find, id}, _, {reader_id, readers} = state) do
    if reader_id < id or id < 1 do
      {:reply, nil, state}
    else
      {:reply, readers[id], state}
    end
  end

  @impl true
  def handle_call(
        {:update, id, %{dni: dni, name: name, lastname: lastname, email: email}},
        _,
        {reader_id, readers} = state
      ) do
    if reader_id < id or id < 1 do
      {:reply, nil, state}
    else
      new_id = id
      new_user = %Reader{_id: new_id, dni: dni, name: name, lastname: lastname, email: email}
      readers = Map.put(readers, new_id, new_user)
      state = {new_id, readers}
      {:reply, new_user, state}
    end
  end

  @impl true
  def handle_call({:delete, id}, _, {reader_id, readers} = state) do
    if reader_id < id or id < 1 do
      {:reply, nil, state}
    else
      readers = Enum.filter(readers, fn {_, map} -> map._id != id end)
      state = {0, readers}
      {:reply, readers, state}
    end
  end
end

defimpl DbHandler, for: ReaderMock do
  def add(handler, %{dni: _, name: _, lastname: _, email: _} = map) do
    GenServer.call(handler.pid, {:add, map})
  end

  def find(handler, filter) do
    GenServer.call(handler.pid, {:find, filter})
  end

  def update(handler, id, %{dni: _, name: _, lastname: _, email: _} = map) do
    GenServer.call(handler.pid, {:update, id, map})
  end

  def delete(handler, id) do
    GenServer.call(handler.pid, {:delete, id})
  end
end
