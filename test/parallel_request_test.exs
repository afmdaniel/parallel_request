defmodule ParallelRequestTest do
  use ExUnit.Case
  doctest ParallelRequest

  test "greets the world" do
    assert ParallelRequest.hello() == :world
  end
end
