defmodule IExSshShell.IEx.Daemon do
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
    port = Application.get_env(:iex_ssh_shell, :port, 2222)

    authorized_keys =
      Application.get_env(:iex_ssh_shell, :authorized_keys, [])
      |> Enum.join("\n")

    decoded_authorized_keys = :public_key.ssh_decode(authorized_keys, :auth_keys)

    cb_opts = [authorized_keys: decoded_authorized_keys]

    sys_dir = system_dir()

    opts = [
      {:max_sessions, 1},
      {:id_string, :random},
      {:key_cb, {IExSshShell.SSH.Keys, cb_opts}},
      {:system_dir, sys_dir},
      {:user_dir, sys_dir },
      {:auth_methods, 'publickey' },
      # {:shell, {Elixir.IEx, :start, []}},
      {:shell, &do_shell/2},
    ] 

    with {:ok, _ref} <- :ssh.daemon port, opts do
      {:ok, %{}}
    else
      {:error, 'No host key available' = msg} ->
        Logger.error "Error starting #{__MODULE__}: #{inspect msg}. Check your config.exs sets a private ssh directory."
        :ignore
      err ->
        Logger.error "Error starting #{__MODULE__}: #{inspect err}"
        :ignore
    end
  end

  def do_shell(username, {ip, port} = peer_address) do
    {_master_pid, session} = Sessions.get_by_peer_address(peer_address)
    ssh_publickey = Map.get(session, "public_key")

    # Create new Process and delegate connection
    shell_handler = Application.fetch_env!(:iex_ssh_shell, :handler) || {Elixir.IEx, :start, []}

    IO.puts("doshell: #{inspect username}, #{inspect ssh_publickey}, #{inspect ip}, #{inspect port}, #{inspect shell_handler}")
    spawn_link(
      shell_handler,
      :incoming,
      [username, ssh_publickey, ip, port])

  end

  def system_dir() do
    sys_dir = cond do
      system_dir = Application.get_env(:iex_ssh_shell, :system_dir) ->
        to_charlist(system_dir)

      File.dir?("/etc/ssh") ->
        to_charlist("/etc/ssh")

      true ->
        :code.priv_dir(:iex_ssh_shell)
    end
    Logger.info "Configured with SSH Directory: #{sys_dir}"
    sys_dir

  end


end
