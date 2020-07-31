defmodule JasonapiTest do
  use ExUnit.Case
  doctest Jasonapi

  test "greets the world" do
    assert Jasonapi.hello() == :world
  end
end
