defmodule IssuesWeb.Router do
  use IssuesWeb, :router

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

  scope "/", IssuesWeb do
    pipe_through :browser

    post "/", PageController, :show
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", IssuesWeb do
  #   pipe_through :api
  # end
end
