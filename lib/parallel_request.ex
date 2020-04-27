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
    status_code = value.status_code
    body = value.body

    if status_code == 200 do
      send(from, {:response, %{status_code: status_code, body: body}})
    else
      send(from, {:error})
    end

    {:noreply, state}
  end
end
