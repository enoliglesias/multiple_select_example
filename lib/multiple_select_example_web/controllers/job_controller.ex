defmodule MultipleSelectExampleWeb.JobController do
  use MultipleSelectExampleWeb, :controller

  alias MultipleSelectExample.Company
  alias MultipleSelectExample.Company.Job

  def index(conn, _params) do
    jobs = Company.list_jobs()
    render(conn, "index.html", jobs: jobs)
  end

  def new(conn, _params) do
    changeset = Company.change_job(%Job{categories: []})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"job" => job_params}) do
    case Company.create_job(job_params) do
      {:ok, job} ->
        conn
        |> put_flash(:info, "Job created successfully.")
        |> redirect(to: job_path(conn, :show, job))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    job = Company.get_job!(id)
    render(conn, "show.html", job: job)
  end

  def edit(conn, %{"id" => id}) do
    job = Company.get_job!(id)
    job = MultipleSelectExample.Repo.preload(job, [:categories])
    changeset = Company.change_job(job)
    render(conn, "edit.html", job: job, changeset: changeset)
  end

  def update(conn, %{"id" => id, "job" => job_params}) do
    job = Company.get_job!(id)
    job = MultipleSelectExample.Repo.preload(job, [:categories])
    case Company.update_job(job, job_params) do
      {:ok, job} ->
        conn
        |> put_flash(:info, "Job updated successfully.")
        |> redirect(to: job_path(conn, :show, job))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", job: job, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    job = Company.get_job!(id)
    {:ok, _job} = Company.delete_job(job)

    conn
    |> put_flash(:info, "Job deleted successfully.")
    |> redirect(to: job_path(conn, :index))
  end
end
