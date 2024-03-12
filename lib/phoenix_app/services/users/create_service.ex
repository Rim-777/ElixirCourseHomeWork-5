defmodule PhoenixApp.Services.Users.CreateService do
  @moduledoc """
  Create Users.
  """

  alias Ecto.Changeset

  use GenServer

  import Ecto.Query, warn: false
  alias PhoenixApp.Repo
  alias PhoenixApp.User

  @timeout 5000

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def exec(pid, attrs \\ %{}) do
    GenServer.cast(pid, {:create, attrs})
  end

  def state(pid) do
    GenServer.call(pid, :get_state)
  end

  @impl GenServer
  def init(_attrs) do
    {:ok, {:init, %User{}}, @timeout}
  end

  @impl GenServer
  def handle_call(:get_state, _from, state) do
    {:reply, state, state, @timeout}
  end

  @impl GenServer
  def handle_cast({:create, attrs}, _state) do
    result =
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()

    new_state =
      case result do
        {:ok, user} -> {:ok, user}
        {:error, %Changeset{valid?: false, errors: errors}} -> {:error, errors}
      end

    {:noreply, new_state, @timeout}
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end
end
