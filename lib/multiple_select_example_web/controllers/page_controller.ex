defmodule MultipleSelectExampleWeb.PageController do
  use MultipleSelectExampleWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
