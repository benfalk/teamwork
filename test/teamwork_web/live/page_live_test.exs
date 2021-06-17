defmodule TeamworkWeb.PageLiveTest do
  use TeamworkWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, _page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Teamwork"

    # Nothing to really test against the live portion yet
    # assert render(page_live) =~ "Teamwork"
  end
end
