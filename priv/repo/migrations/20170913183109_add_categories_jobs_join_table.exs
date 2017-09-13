defmodule MultipleSelectExample.Repo.Migrations.AddCategoriesJobsJoinTable do
  use Ecto.Migration

  def change do
    create table(:categories_jobs, primary_key: false) do
      add :category_id, references(:categories)
      add :job_id, references(:jobs)
    end

    create unique_index(:categories_jobs, [:category_id, :job_id])
  end
end
