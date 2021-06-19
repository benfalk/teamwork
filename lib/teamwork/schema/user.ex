defmodule Teamwork.Schema.User do
  use Teamwork.Schema
  alias __MODULE__, as: User

  schema "users" do
    field(:email, :string)
    field(:avatar, :string)
    timestamps()
  end

  def new(params \\ %{}), do: changeset(%User{}, params)

  def changeset(%User{} = user, params \\ %{}) do
    user
    |> cast(params, [:email, :avatar])
    |> validate_required([:email, :avatar])
    |> unique_constraint(:email, name: :index_accounts_lowercase_email)
  end
end
