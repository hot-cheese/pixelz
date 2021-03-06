defmodule PixelzWeb.BoardChannelTest do
  use PixelzWeb.ChannelCase

  alias PixelzWeb.BoardChannel

  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(BoardChannel, "board:lobby")

    {:ok, socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "paint_pixel broadcasts to board:lobby", %{socket: socket} do
    push socket, "paint_pixel", %{"hello" => "all"}
    assert_broadcast "paint_pixel", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
