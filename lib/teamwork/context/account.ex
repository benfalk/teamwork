defmodule Teamwork.Account do
  require Logger

  def find_or_create_from_auth(%{strategy: Ueberauth.Strategy.Google} = auth) do
    {:ok, %{email: auth.info.email, avatar: auth.info.image}}
  end

  def find_or_create_from_auth(auth) do
    Logger.error("Unsupported Auth: #{inspect(auth)}")

    {:error, "auth not supported"}
  end
end
