defmodule MultipleSelectExampleWeb.Router do
  use MultipleSelectExampleWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MultipleSelectExampleWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/jobs", JobController
    resources "/categories", CategoryController
  end

  # Other scopes may use custom stacks.
  # scope "/api", MultipleSelectExampleWeb do
  #   pipe_through :api
  # end
end
