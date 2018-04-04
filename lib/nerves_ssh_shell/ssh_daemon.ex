defmodule NervesSshShell.IEX.Daemon do
  @moduledoc false

  use GenServer
  require Logger

  ## Client API

  @doc """
  """
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  ## Server Callbacks

  def init(:ok) do
    port = Application.get_env(:nerves_ssh_shell, :port, 2222)

    authorized_keys =
      Application.get_env(:nerves_ssh_shell, :authorized_keys, [])
      |> Enum.join("\n")
      |> IO.inspect(label: :authorized_keys)

    decoded_authorized_keys = :public_key.ssh_decode(authorized_keys, :auth_keys)

    cb_opts = [authorized_keys: decoded_authorized_keys]

    opts = [
      {:max_sessions, 1},
      {:id_string, :random},
      {:key_cb, {NervesSshShell.SSH.Keys, cb_opts}},
      {:system_dir, system_dir() |> IO.inspect(label: :system_dir)},
      {:user_dir, system_dir() },
      {:shell, {Elixir.IEx, :start, []}},
    ] |> IO.inspect(label: :ssh_opts)

    {:ok, _ref} =
      :ssh.daemon port, opts
  end

  def system_dir() do
    cond do
      system_dir = Application.get_env(:nerves_ssh_shell, :system_dir) ->
        to_charlist(system_dir)

      File.dir?("/etc/ssh") ->
        to_charlist("/etc/ssh")

      true ->
        :code.priv_dir(:nerves_ssh_shell)
    end
  end
end
