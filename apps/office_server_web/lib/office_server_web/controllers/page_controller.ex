defmodule OfficeServerWeb.PageController do
  use OfficeServerWeb, :controller

  def index(conn, _params) do
    text(conn, "hi")
  end
end
