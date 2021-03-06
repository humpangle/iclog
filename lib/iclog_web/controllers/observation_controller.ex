defmodule IclogWeb.ObservationController do
  use IclogWeb, :controller

  alias Iclog.Observable.Observation

  action_fallback IclogWeb.FallbackController

  def index(conn, _params) do
    observations = Observation.list()
    render(conn, "index.json", observations: observations)
  end

  def create(conn, %{"observation" => observation_params}) do
    with {:ok, %Observation{} = observation} <- Observation.create(observation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", observation_path(conn, :show, observation))
      |> render("show.json", observation: observation)
    end
  end

  def show(conn, %{"id" => id}) do
    observation = Observation.get!(id)
    render(conn, "show.json", observation: observation)
  end

  def update(conn, %{"id" => id, "observation" => observation_params}) do
    observation = Observation.get!(id)

    with {:ok, %Observation{} = observation} <- Observation.update(observation, observation_params) do
      render(conn, "show.json", observation: observation)
    end
  end

  def delete(conn, %{"id" => id}) do
    observation = Observation.get!(id)
    with {:ok, %Observation{}} <- Observation.delete(observation) do
      send_resp(conn, :no_content, "")
    end
  end
end
