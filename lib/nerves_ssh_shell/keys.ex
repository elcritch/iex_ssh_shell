defmodule NervesSshShell.SSH.Keys do
  @moduledoc false

  @supported_keys Application.get_env(:nerves_ssh_shell, :supported_keys, [:"rsa-sha2-256", :"rsa-sha2-512", :"ssh-rsa", :"ecdsa-sha2-nistp256", "ecdsa-sha2-nistp384", "ecdsa-sha2-nistp521"])
  @ephemeral_server_key Application.get_env(:nerves_ssh_shell, :ephemeral_server_key, nil)

  def host_key(algorithm, options) do
    cond do
      ### Commenting this out for now, ephemeral keys don't really provide any benefits against MITM style attacks... 
      # algorithm == :"ssh-rsa" && algorithm == @ephemeral_server_key ->
      #   IO.inspect {algorithm}, label: :host_key
      #   IO.inspect self(), label: :host_key_pid
      #   rsa_key = :public_key.generate_key {:rsa, 2048, 3}
      #   Process.put(:ephemeral_key, rsa_key)
      #   {:ok, rsa_key}

      algorithm in @supported_keys ->
        IO.inspect {algorithm}, label: :host_key
        IO.inspect :ssh_file.host_key(algorithm, options), label: :ssh_file_host_key

      true ->
        IO.inspect {algorithm}, label: :ignored_host_key
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
