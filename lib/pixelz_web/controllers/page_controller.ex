defmodule PixelzWeb.PageController do
  use PixelzWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
