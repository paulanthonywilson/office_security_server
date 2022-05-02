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
    <div class="relative bg-blue-600 md:pt-10 pb-32 pt-12">
      <div class="px-4 md:px-10 mx-auto w-full h-screen">
        <div class="">
          <.connection_status/>
          <!-- Card stats -->
          <div class="flex flex-wrap my-4 pt-10">
            <.text_card title="Temperature" content="-1.34" sub_content="11:15:01 13/01/2022" icon="fa fa-temperature-half" icon_colour="bg-blue-800"/>
            <.text_card title="Last movement" content="13:11:01" sub_content="13/01/2022" icon="fa fa-person-running" icon_colour="bg-orange-500"/>
            <.text_card title="Occupation" content="Vacant" sub_content="11:15:01 13/01/2022" icon="fa fa-person-through-window" icon_colour="bg-pink-500"/>
            <.text_card title="Uptime" content="2d 15h 16m" sub_content="11:15:01 13/01/2022" icon="fa fa-stopwatch" icon_colour="bg-green-500"/>
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp connection_status(assigns) do
    ~H"""
    <div class="flex flex-wrap my-4">
    <div class="p-6 max-w-sm mx-auto bg-white rounded-xl shadow-lg flex items-center space-x-4 bg-green-500">
    <div class="mx-auto text-xl font-medium text-black bg-green-450">Connected</div>
    </div>
    </div>
    """
  end

  defp text_card(assigns) do
    icon_class =
      "text-white p-3 text-center inline-flex items-center justify-center w-12 h-12 shadow-lg rounded-full #{assigns.icon_colour}"

    ~H"""
    <div class="w-full lg:w-6/12 xl:w-3/12 px-4">
    <div class="relative flex flex-col min-w-0 break-words bg-white rounded-xl mb-6 xl:mb-0 shadow-lg">
      <div class="flex-auto p-4">
        <div class="flex flex-wrap">
          <div class="relative w-full pr-4 max-w-full flex-grow flex-1">
            <h5 class="text-blueGray-400 uppercase font-bold text-xs">
              <%= @title %>
            </h5>
            <span class="font-semibold text-xl text-blueGray-700">
              <%= @content %>
            </span>
          </div>
          <div class="relative w-auto pl-4 flex-initial">
            <div class={icon_class}>
              <i class={@icon}></i>
            </div>
          </div>
        </div>
        <p class="text-sm text-blueGray-400 mt-4">
          <span class="whitespace-nowrap">
             <%= @sub_content %>
          </span>
        </p>
      </div>
    </div>
    </div>
    """
  end
end
