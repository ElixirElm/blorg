defmodule Blorg.Router do
  use Blorg.Web, :router

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

  scope "/", Blorg do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Blorg do
  #   pipe_through :api
  # end
  

  scope "/api", Blorg.API do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/articles", ArticleController, only: [:index, :show]

      # scope "/subscope", Subscope, as: :subscope do
      # end
    end
  end  
  
end
