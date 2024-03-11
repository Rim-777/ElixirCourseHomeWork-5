defmodule PhoenixApp.Users.Create do
  @moduledoc """
  Create Users.
  """

  import Ecto.Query, warn: false
  alias PhoenixApp.Repo
  alias PhoenixApp.Users.User

  def exec(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
