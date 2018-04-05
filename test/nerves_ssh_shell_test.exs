defmodule IExSshShellTest do
  use ExUnit.Case
  doctest IExSshShell

  test "greets the world" do
    assert IExSshShell.hello() == :world
  end
end
