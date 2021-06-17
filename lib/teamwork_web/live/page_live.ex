defmodule TeamworkWeb.PageLive do
  use TeamworkWeb, :live_view
  require Logger

  @impl true
  def mount(_params, session, socket) do
    Logger.debug("session: #{inspect(session)}")

    {:ok,
     assign(socket,
       query: "",
       results: %{},
       current_user: session["current_user"]
     )}
  end
end
