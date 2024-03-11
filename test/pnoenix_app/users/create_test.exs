defmodule PhoenixApp.Users.CreateTest do
  use ExUnit.Case
  alias PhoenixApp.Users.User
  alias PhoenixApp.Users.Create
  alias PhoenixApp.Repo
  alias Ecto.Changeset

  setup do
    Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "exes" do
    test "stores a valid user in DB" do
      attrs = %{
        name: "Matroskin",
        email: "matroskin@prostokvashino.quest",
        bio: "unbelievable"
      }

      {:ok, %User{} = created_user} = Create.exec(attrs)

      stored_user = Repo.get(User, created_user.id)

      assert created_user == stored_user
    end

    test "returns errors" do
      errors = [
        {:name, {"can't be blank", [validation: :required]}},
        {:email, {"can't be blank", [validation: :required]}}
      ]

      assert {:error, %Changeset{valid?: false, errors: ^errors}} = Create.exec(%{})
    end
  end
end
