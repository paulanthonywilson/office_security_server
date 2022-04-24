defmodule OfficeServerWeb.AuthCommonView do
  defmacro __using__(_) do
    quote do
      use OfficeServerWeb, :view

      def form_box(title, level \\ 1, inner) do
        middle = safe_to_string(inner.())

        raw("""
        <div class="container mx-auto px-4 h-full">
        <div class="flex content-center items-center justify-center h-full">
        <div class="w-full lg:w-4/12 px-4">
        <div class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-gray-300 border-0">
        <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
        <h#{level} class="text-gray-500 text-center mb-3 font-bold">#{title}</h#{level}>
        #{middle}
        </div></div></div></div></div>
        """)
      end

      def field(inner) do
        middle = safe_to_string(inner.())
        raw(~s|<fieldset class="relative w-full mb-3">#{middle}</fieldset>|)
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

      def bottom_links(link1, link2) do
        raw("""
        <div class="flex flex-wrap mt-6">
        <div class="1/2">
          <small>#{safe_to_string(link1)}</small>
         </div>
        <div class="w-1/2 text-right">
        <small>#{safe_to_string(link2)}</small>
         </div>
        </div>
        """)
      end
    end
  end
end