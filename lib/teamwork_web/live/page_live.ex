defmodule TeamworkWeb.PageLive do
  use TeamworkWeb, :live_view
  require Logger

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     assign(socket,
       current_user: session["current_user"]
     )}
  end
end
