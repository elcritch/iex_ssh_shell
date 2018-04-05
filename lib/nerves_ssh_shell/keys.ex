defmodule IExSshShell.SSH.Keys do
  @moduledoc false

  @supported_keys Application.get_env(:iex_ssh_shell, :supported_keys, [:"rsa-sha2-256", :"rsa-sha2-512", :"ssh-rsa", :"ecdsa-sha2-nistp256", "ecdsa-sha2-nistp384", "ecdsa-sha2-nistp521"])

  def host_key(algorithm, options) do
    cond do

      algorithm in @supported_keys ->
        :ssh_file.host_key(algorithm, options)

      true ->
        {:error, {:badmatch, {:error, :eacces}}}
    end

  end

  def is_auth_key(key, _user, options) do
    # Grab the decoded authorized keys from the options
    cb_opts = Keyword.get(options, :key_cb_private)
    keys = Keyword.get(cb_opts, :authorized_keys)

    # If any of them match, then we're good.
    Enum.any?(keys, fn {k, _info} -> k == key end)
  end
end
