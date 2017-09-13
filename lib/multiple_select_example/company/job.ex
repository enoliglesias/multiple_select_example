defmodule MultipleSelectExample.Company.Job do
  use Ecto.Schema
  import Ecto.Changeset
  alias MultipleSelectExample.Company.Job
  alias MultipleSelectExample.Repo


  schema "jobs" do
    field :title, :string

    timestamps()

    many_to_many :categories, MultipleSelectExample.Company.Category, join_through: "categories_jobs", on_delete: :delete_all, on_replace: :delete
  end

  @doc false
  def changeset(%Job{} = job, attrs) do
    job
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> put_assoc(:categories, parse_categories(attrs))
  end

  defp parse_categories(params)  do
    (params["categories"] || [])
    |> Enum.map(&(Repo.get_by(MultipleSelectExample.Company.Category, id: &1)))
  end

end
