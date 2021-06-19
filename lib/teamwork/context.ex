defmodule Teamwork.Context do
  @moduledoc """
  This is meant to be be used for any module which is a 
  context for datab interactions.
  """
  defmacro __using__(_) do
    quote do
      import Ecto.Changeset
      import Ecto.Query, only: [from: 2, from: 1]
    end
  end
end
