defmodule SneakerfansElixir.Router do
  use SneakerfansElixir.Web, :router

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

  scope "/", SneakerfansElixir do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/absinthe" do
    pipe_through :api
    forward "/", Absinthe.Plug,
    schema: SneakerfansElixir.Schema
  end

  # Other scopes may use custom stacks.
  # scope "/api", SneakerfansElixir do
  #   pipe_through :api
  # end
end
