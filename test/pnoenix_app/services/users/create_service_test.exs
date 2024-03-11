defmodule PhoenixApp.Services.Users.CreateServiceTest do
  use ExUnit.Case
  alias PhoenixApp.User
  alias PhoenixApp.Services.Users.CreateService
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

      {:ok, %User{} = created_user} = CreateService.exec(attrs)

      stored_user = Repo.get(User, created_user.id)

      assert created_user == stored_user
    end

    test "returns errors" do
      errors = [
        {:name, {"can't be blank", [validation: :required]}},
        {:email, {"can't be blank", [validation: :required]}}
      ]

      assert {:error, %Changeset{valid?: false, errors: ^errors}} = CreateService.exec(%{})
    end
  end
end
