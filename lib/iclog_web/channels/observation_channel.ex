defmodule IclogWeb.ObservationChannel do
  use IclogWeb, :channel

  alias IclogWeb.Schema

  def join("observation:observation", %{"params" => params, "query" => query}, socket) do
    {_, reply} = Absinthe.run(query, Schema, variables: params)
    {:ok, absinthe_response(reply), socket}
  end

  def handle_in(
      "new_observation",
      %{ "with_meta" => _, "query" => mutation, "params" => params },
      socket) do
    reply = Absinthe.run(mutation, Schema, variables: params)

    {:reply, absinthe_response(reply), socket}
  end
  def handle_in(
      "new_observation",
      %{ "query" => mutation, "params" => params },
      socket) do
    reply = Absinthe.run(mutation, Schema, variables: params)

    {:reply, absinthe_response(reply), socket}
  end
  def handle_in(
      "search_metas_by_title",
      %{"query" => query, "params" => params },
      socket) do
    reply = Absinthe.run(query, Schema, variables: params)

    {:reply, absinthe_response(reply), socket}
  end
  def handle_in(
      "list_observations",
      %{"query" => query, "params" => params },
      socket) do
    reply = Absinthe.run(query, Schema, variables: params)

    {:reply, absinthe_response(reply), socket}
  end
  def handle_in(
      "get_observation",
      %{"query" => query, "params" => params },
      socket) do
    reply = Absinthe.run(query, Schema, variables: params)

    {:reply, absinthe_response(reply), socket}
  end

  defp absinthe_response({:ok, %{errors: error}}) do
    {:error, %{errors: error}}
  end

  defp absinthe_response(val) do
    val
  end
end
