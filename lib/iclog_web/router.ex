defmodule IclogWeb.Router do
  use IclogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", IclogWeb do
    pipe_through :api
    resources "/observation_metas", ObservationMetaController, except: [:new, :edit]
  end
end
