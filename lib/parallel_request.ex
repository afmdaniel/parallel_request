defmodule ParallelRequest do
  @moduledoc """
  Documentation for `ParallelRequest`.
  """

  use GenServer

  @doc """
  Hello world.

  ## Examples

      iex> ParallelRequest.hello()
      :world
  """
  def start_link(conf \\ []) do
    GenServer.start_link(__MODULE__, conf, name: __MODULE__)
  end

  def init(conf) do
    {:ok, conf}
  end

  def handle_info({:request, url, from}, state) do
    value = HTTPoison.get!(url)

    if value.status_code == 200 do
      send(from, {:response, value.body})
    else
      send(from, {:error})
    end

    {:noreply, state}
  end
end
