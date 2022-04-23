defmodule OfficeServerWeb.PageView do
  use OfficeServerWeb, :view
end
defmodule OfficeServerWeb.PageController do
  use OfficeServerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
