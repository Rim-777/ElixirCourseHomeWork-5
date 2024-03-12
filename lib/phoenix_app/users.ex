defmodule PhoenixApp.Users do
  @moduledoc """
  Create Users.
  """

  import Ecto.Query, warn: false
  alias PhoenixApp.Repo
  alias PhoenixApp.Users.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
