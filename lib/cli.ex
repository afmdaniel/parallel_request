defmodule ParallelRequest.CLI do
  def main(args \\ []) do
    ParallelRequest.start_link()

    args
    |> Enum.map(fn url -> send(ParallelRequest, {:request, url, self()}) end)

    receive do
      {:response, resp} -> resp |> Poison.encode!() |> IO.puts()
    after
      10_000 -> IO.puts("{status_code: 401}")
    end
  end
end
