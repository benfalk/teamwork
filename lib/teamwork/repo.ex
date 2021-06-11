defmodule Teamwork.Repo do
  use Ecto.Repo,
    otp_app: :teamwork,
    adapter: Ecto.Adapters.Postgres
end
