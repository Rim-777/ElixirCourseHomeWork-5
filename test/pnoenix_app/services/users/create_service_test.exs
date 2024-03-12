defmodule PhoenixApp.Services.Users.CreateServiceTest do
  use ExUnit.Case
  alias PhoenixApp.User
  alias PhoenixApp.Services.Users.CreateService
  alias PhoenixApp.Repo

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(PhoenixApp.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})
  end

  describe "exes" do
    test "stores a valid user in DB" do
      {:ok, pid} = CreateService.start_link()

      attrs = %{
        name: "Matroskin",
        email: "matroskin@prostokvashino.quest",
        bio: "unbelievable"
      }

      :ok = CreateService.exec(pid, attrs)
      {:ok, created_user} = CreateService.state(pid)
      stored_user = Repo.get(User, created_user.id)

      assert created_user == stored_user
    end

    test "returns errors" do
      {:ok, pid} = CreateService.start_link()
      :ok = CreateService.exec(pid, %{})

      expected_errors = [
        {:name, {"can't be blank", [validation: :required]}},
        {:email, {"can't be blank", [validation: :required]}}
      ]

      {:error, errors} = CreateService.state(pid)

      assert errors == expected_errors
    end
  end
end
