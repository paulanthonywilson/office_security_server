defmodule OfficeServerWeb.AuthCommon do
  use Phoenix.Component
  use Phoenix.HTML

  def form_box(assigns) do
    ~H"""
    <div class="container mx-auto px-4 h-full">
    <div class="flex content-center items-center justify-center h-full">
    <div class="w-full lg:w-4/12 px-4">
    <div class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-gray-300 border-0">
    <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
    <h1 class="text-gray-500 text-center mb-3 font-bold"><%= @title %></h1>
    <%= render_slot(@inner_block) %>
    </div></div></div></div></div>
    """
  end

  def field(assigns) do
    ~H"""
    <fieldset class="relative w-full mb-3"><%= render_slot(@inner_block) %></fieldset>
    """
  end

  def bottom_links(assigns) do
    ~H"""
    <div class="flex flex-wrap mt-6">
    <div class="1/2">
      <small><%= render_slot(@l1) %></small>
     </div>
    <div class="w-1/2 text-right">
      <small><%= render_slot(@l2) %></small>
     </div>
    </div>
    """
  end

  def label_class do
    "block uppercase text-gray-700 text-xs font-bold mb-2"
  end

  def field_class do
    "border-0 px-3 py-3 placeholder-gray-400 text-gray-700 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full"
  end

  def checkbox_class do
    "form-checkbox border-0 rounded text-gray-800 ml-1 w-5 h-5"
  end

  def checkbox_label do
    "ml-2 text-sm font-semibold text-gray-700"
  end

  def submit_class do
    "bg-gray-900 text-white active:bg-gray-700 text-sm font-bold uppercase px-6 py-3 rounded shadow hover:shadow-lg outline-none focus:outline-none mr-1 mb-1 w-full"
  end
end
