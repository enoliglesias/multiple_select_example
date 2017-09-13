defmodule MultipleSelectExample.Company.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias MultipleSelectExample.Company.Category


  schema "categories" do
    field :title, :string

    timestamps()

    many_to_many :jobs, MultipleSelectExample.Company.Job, join_through: "categories_jobs", on_delete: :delete_all, on_replace: :delete
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> put_assoc(:categories, parse_jobs(attrs))
  end

  defp parse_jobs(params)  do
    (params["jobs"] || [])
    |> Enum.map(&(MultipleSelectExample.Repo.get_by(MultipleSelectExample.Company.Job, id: &1)))
  end
end
