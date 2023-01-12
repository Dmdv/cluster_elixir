defmodule ClusterElixirTest do
  use ExUnit.Case
  doctest ClusterElixir

  test "greets the world" do
    assert ClusterElixir.hello() == :world
  end
end
