defmodule OfficeServerWeb.BoxRegistrationControllerTest do
  use OfficeServerWeb.ConnCase, async: true

  alias OfficeServer.Boxes

  import OfficeServer.AccountsFixtures

  @email "bob@example.com"
  @password "spiceyarrakis"

  setup do
    %{id: user_id} = user_fixture(email: @email, password: @password)
    {:ok, user_id: user_id}
  end

  test "registering", %{user_id: user_id, conn: conn} do
    route = Routes.box_registration_path(conn, :register)

    assert %{"token" => token} =
             conn
             |> post(route, %{
               email: @email,
               password: @password,
               board_id: "bored123",
               name: "bob"
             })
             |> json_response(201)

    assert {:ok, %{owner_id: ^user_id, board_id: "bored123", name: "bob"}} =
             Boxes.from_token(token)
  end

  test "failing to register", %{conn: conn} do
    route = Routes.box_registration_path(conn, :register)

    conn
    |> post(route, %{email: @email, password: "h4ck0rz3d!", board_id: "aaa", name: "bbb"})
    |> json_response(401)
  end

  test "bad request", %{conn: conn} do
    route = Routes.box_registration_path(conn, :register)

    conn
    |> post(route, %{})
    |> json_response(400)
  end

  test "missing values", %{conn: conn} do
    route = Routes.box_registration_path(conn, :register)

    conn
    |> post(route, %{
      email: @email,
      password: @password,
      board_id: "",
      name: ""
    })
    |> json_response(400)
  end
end
