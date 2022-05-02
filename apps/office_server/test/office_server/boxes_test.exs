defmodule OfficeServer.BoxesTest do
  use OfficeServer.DataCase

  alias OfficeServer.{Boxes, Tokens}

  alias OfficeServer.Boxes.Box

  import OfficeServer.{BoxesFixtures, AccountsFixtures}

  @email "marvin@example.com"
  @password "discount tents"
  @bad_token "QTEyOEdDTQ.6YQd_WV_Gwlrysk17WucbHT2kZClSohBvedpGBTa469LKeNhqh_YmAErEfU.znOLe4_szIVSGYiO.rt-C5E57BQrPWwsNWRo_orG4fg.tsUDs-rIbohqeyZqvMpQ6w"

  setup do
    %{id: user_id} = user_fixture(password: @password, email: @email)
    {:ok, user_id: user_id}
  end

  describe "registering a box" do
    test "register a box, creates a box accessible by that user", %{user_id: user_id} do
      assert {:ok, _token} = Boxes.register(@email, @password, "000000002c7a379a", "379a")

      assert [%Box{owner_id: ^user_id, name: "379a", board_id: "000000002c7a379a"}] =
               Boxes.boxes_owned_by(user_id)
    end

    test "correct password must be used" do
      assert {:error, :authentication} ==
               Boxes.register(@email, "hacker001", "000000002c7a379a", "379a")
    end

    test "nil details are not allowed" do
      assert {:error, %{errors: errors}} = Boxes.register(@email, @password, nil, nil)

      assert {_, [{:validation, :required}]} = Keyword.get(errors, :board_id)
      assert {_, [{:validation, :required}]} = Keyword.get(errors, :name)
    end

    test "registering the same board id with the same user just updates", %{user_id: user_id} do
      assert {:ok, _token} = Boxes.register(@email, @password, "000000002c7a379a", "379a")
      assert {:ok, _token} = Boxes.register(@email, @password, "000000002c7a379a", "fred")

      assert [%Box{owner_id: ^user_id, name: "fred", board_id: "000000002c7a379a"}] =
               Boxes.boxes_owned_by(user_id)
    end
  end

  describe "users boxes" do
    setup %{user_id: user_id} do
      %{id: box_id} = box_fixture(user_id)
      %{id: bystander_id} = user_fixture()
      {:ok, box_id: box_id, bystander_id: bystander_id}
    end

    test "getting boxes owned_by user only returns that users boxes", %{
      box_id: box_id,
      user_id: user_id,
      bystander_id: bystander_id
    } do
      assert [%{id: ^box_id}] = Boxes.boxes_owned_by(user_id)
      assert [] = Boxes.boxes_owned_by(bystander_id)
    end

    test "getting a box by id requires the owner id", %{
      box_id: box_id,
      user_id: user_id,
      bystander_id: bystander_id
    } do
      assert {:ok, %{id: ^box_id}} = Boxes.get(user_id, box_id)
      assert {:error, :not_found} = Boxes.get(bystander_id, box_id)
      assert {:error, :not_found} = Boxes.get(user_id, -box_id)
    end
  end

  describe "tokens" do
    setup do
      {:ok, token} = Boxes.register(@email, @password, "000000002c7a379a", "379a")
      {:ok, token: token}
    end

    test "registration token can be used to get the box", %{user_id: user_id, token: token} do
      assert {:ok, %{name: "379a", owner_id: ^user_id}} = Boxes.from_token(token)
    end

    test "valid token must be used" do
      assert {:error, :invalid} = Boxes.from_token(@bad_token)
    end

    test "expired tokens are not ok", %{token: token} do
      {:ok, %{id: box_id}} = Boxes.from_token(token)
      expired = Tokens.to_token(box_id, :box, signed_at: 0)
      assert {:error, :expired} = Boxes.from_token(expired)
    end

    test "not found if the box does not exist" do
      token = Tokens.to_token(-11, :box)
      assert {:error, :not_found} = Boxes.from_token(token)
    end

    test "refreshing a token", %{token: token, user_id: user_id} do
      assert {:ok, refreshed} = Boxes.refresh_token(token)
      assert refreshed != token
      assert {:ok, %{name: "379a", owner_id: ^user_id}} = Boxes.from_token(refreshed)
    end

    test "bad tokens do not refresh" do
      assert {:error, :invalid} = Boxes.refresh_token(@bad_token)
    end
  end
end
