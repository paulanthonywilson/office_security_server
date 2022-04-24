defmodule OfficeServerWeb.BoxesLive do
  @moduledoc """
  Lists the registered boxes
  """
  use OfficeServerWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    Nothing implemented yet
    """
  end
end
