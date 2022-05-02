defmodule OfficeServerWeb.MenuComponent do
  @moduledoc """
  The side menu
  """
  use OfficeServerWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <nav class="md:left-0 md:block md:fixed md:top-0 md:bottom-0 md:overflow-y-auto md:flex-row md:flex-nowrap md:overflow-hidden shadow-xl bg-white flex flex-wrap items-top justify-between relative md:w-64 z-10 py-4 px-6">
    <div class="md:flex-col md:items-stretch md:min-h-full md:flex-nowrap px-0 flex flex-wrap items-center justify-start w-full mx-auto">
    <a class="md:block text-left md:pb-2 text-blueGray-600 mr-0 inline-block whitespace-nowrap text-sm uppercase font-bold p-4 px-0" href="javascript:void(0)">
    The Office
    </a>
    <ul class="md:flex-col md:min-w-full flex flex-col list-none">
    <li class="items-top">
    <a class="text-pink-500 hover:text-pink-600 text-xs uppercase py-3 font-bold block" href="#/dashboard">
      Dashboard</a>
    </li>
    </ul>
    </div>
    </nav>
    """
  end
end
