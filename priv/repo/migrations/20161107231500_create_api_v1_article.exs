defmodule Blorg.Repo.Migrations.CreateAPI.V1.Article do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :body, :text

      timestamps()
    end

  end
end
