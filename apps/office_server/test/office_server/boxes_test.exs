defmodule OfficeServer.BoxesTest do
  use OfficeServer.DataCase

  alias OfficeServer.Boxes

  alias OfficeServer.Boxes.Box

  import OfficeServer.{BoxesFixtures, AccountsFixtures}

  setup do
    %{id: user_id} = user_fixture(password: "discount tents", email: "marvin@example.com")
    {:ok, user_id: user_id}
  end

  describe "registering a box" do
    test "register a box, creates a box accessible by that user", %{user_id: user_id} do
      assert {:ok, _token} =
               Boxes.register("marvin@example.com", "discount tents", "000000002c7a379a", "379a")

      assert [%Box{owner_id: ^user_id, name: "379a", board_id: "000000002c7a379a"}] =
               Boxes.boxes_owned_by(user_id)
    end

    test "correct password must be used" do
      assert {:error, :authentication} ==
               Boxes.register("marvin@example.com", "hacker001", "000000002c7a379a", "379a")
    end

    test "nil details are not allowed" do
      assert {:error, %{errors: errors}} = Boxes.register("marvin@example.com", "discount tents", nil, nil)
      assert {_, [validation_required]} =  Keyword.get(errors, :board_id)
      assert Keyword.get(errors, :name)
    end

    # nil values
    # token
  end

  # only return boxes owned by user
  # refresh token
  # box for id
  # box for id, wrong user
  # box for token
  # token for box
end
