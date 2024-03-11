defmodule PhoenixApp.Services.Users.CreateService do
  @moduledoc """
  Create Users.
  """

  import Ecto.Query, warn: false
  alias PhoenixApp.Repo
  alias PhoenixApp.User

  def exec(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
