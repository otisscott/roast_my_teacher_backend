defmodule RMT.Web.Router do
  use RMT.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

  scope "/", RMT.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", RMT.API do
    pipe_through :api

    post "/login", LoginController, :login
    resources "/teachers", TeacherController, except: [:new, :edit] do
      resources "/roasts", RoastController, except: [:new, :edit]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", RMT.Web do
  #   pipe_through :api
  # end
end
