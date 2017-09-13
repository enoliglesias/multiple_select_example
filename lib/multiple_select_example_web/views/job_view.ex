defmodule MultipleSelectExampleWeb.JobView do
  use MultipleSelectExampleWeb, :view
  import Ecto.Query, only: [from: 2]

  def categories_ids(changeset, conn) do
    get_in(conn.params, ["job", "categories"]) || Enum.map(changeset.data.categories, &(&1.id))
  end

  def category_options() do
    query = from category in MultipleSelectExample.Company.Category,
      select: {category.title, category.id}
    MultipleSelectExample.Repo.all(query)
  end
end
