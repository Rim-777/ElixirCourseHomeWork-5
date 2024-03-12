defmodule PhoenixApp.Users.UserTest do
  use ExUnit.Case
  alias PhoenixApp.User

  describe "db fields" do
    test "it contains expected fields" do
      assert User.__schema__(:fields) == [
               :id,
               :name,
               :email,
               :bio,
               :number_of_pets,
               :inserted_at,
               :updated_at
             ]
    end

    test "all the fields have expected types" do
      expected_map_fields = %{
        name: :string,
        email: :string,
        bio: :string,
        number_of_pets: :integer
      }

      Enum.each(
        expected_map_fields,
        fn {field, type} ->
          assert(User.__schema__(:type, field)) == type
        end
      )
    end
  end
end
