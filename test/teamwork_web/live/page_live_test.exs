defmodule TeamworkWeb.PageLiveTest do
  use TeamworkWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Root Page"
    assert render(page_live) =~ "Root Page"
  end
end
