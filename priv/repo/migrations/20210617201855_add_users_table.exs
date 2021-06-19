defmodule Teamwork.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:email, :string)
      add(:avatar, :string)
      timestamps()
    end

    execute("""
    CREATE UNIQUE INDEX index_accounts_lowercase_email
    ON users
    USING btree (lower((email)::text));
    """)
  end
end
