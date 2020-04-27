defmodule ParallelRequest.CLI do
  def main(args \\ []) do
    ParallelRequest.start_link()

    args
    |> Enum.map(fn url -> send(ParallelRequest, {:request, url, self()}) end)

    receive do
      {:response, body} -> IO.puts(body)
    after
      10_000 -> "Nada em 10s"
    end
  end
end
