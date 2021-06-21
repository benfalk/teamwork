defmodule Teamwork.Repo.Migrations.AddTeams do
  use Ecto.Migration

  def change do
    execute(
      # Up
      """
      CREATE TYPE team_member_role
      AS ENUM (
        'admin',
        'moderator',
        'user'
      );
      """,

      # Down
      """
      DROP TYPE team_member_role;
      """
    )

    create table(:teams, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:name, :string)
      timestamps()
    end

    create table(:team_members, primary_key: false) do
      add(:user_id, references(:users, on_delete: :nothing, type: :uuid), primary_key: true)
      add(:team_id, references(:teams, on_delete: :nothing, type: :uuid), primary_key: true)
      add(:role, :team_member_role)
      timestamps()
    end

    create(index(:team_members, [:user_id]))
    create(index(:team_members, [:team_id]))
  end
end
