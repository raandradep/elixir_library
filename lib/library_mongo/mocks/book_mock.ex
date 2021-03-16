defmodule BookMock do
  defstruct [:pid]

  use GenServer

  def create() do
    {:ok, pid} = GenServer.start_link(__MODULE__, {0, %{}})
    %BookMock{pid: pid}
  end

  @impl true
  def init(state), do: {:ok, state}

  @impl true
  def handle_call({:add, %{isbn: isbn, title: title, description: description, publishedDate: publishedDate, number_total_copies: number_total_copies}}, _, {book_id, books}) do
    new_id = book_id + 1
    new_user = %Book{_id: new_id, isbn: isbn, title: title, description: description, publishedDate: publishedDate, number_total_copies: number_total_copies}
    books = Map.put(books, new_id, new_user)
    state = {new_id, books}
    {:reply, new_user, state}
  end

  @impl true
  def handle_call({:find, id}, _, {book_id, books} = state) do
    if book_id < id or id < 1 do
      {:reply, nil, state}
    else
      {:reply, books[id], state}
    end
  end

  @impl true
  def handle_call(
        {:update, id, %{isbn: isbn, title: title, description: description, publishedDate: publishedDate, number_total_copies: number_total_copies}},
        _,
        {book_id, books} = state
      ) do
    if book_id < id or id < 1 do
      {:reply, nil, state}
    else
      new_id = id
      new_book = %Book{_id: new_id, isbn: isbn, title: title, description: description, publishedDate: publishedDate, number_total_copies: number_total_copies}
      books = Map.put(books, new_id, new_book)
      state = {new_id, books}
      {:reply, new_book, state}
    end
  end

  @impl true
  def handle_call({:delete, id}, _, {book_id, books} = state) do
    if book_id < id or id < 1 do
      {:reply, nil, state}
    else
      books = Enum.filter(books, fn {_, map} -> map._id != id end)
      state = {0, books}
      {:reply, books, state}
    end
  end
end

defimpl DbHandler, for: BookMock do
  def add(handler, %{isbn: _, title: _, description: _, publishedDate: _, number_total_copies: _} = map) do
    GenServer.call(handler.pid, {:add, map})
  end

  def find(handler, filter) do
    GenServer.call(handler.pid, {:find, filter})
  end

  def update(handler, id, %{isbn: _, title: _, description: _, publishedDate: _, number_total_copies: _}  = map) do
    GenServer.call(handler.pid, {:update, id, map})
  end

  def delete(handler, id) do
    GenServer.call(handler.pid, {:delete, id})
  end
end
