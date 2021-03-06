defmodule IExSshShell do
  @moduledoc """
  IExSshShell provides a simple OTP application which runs an SSH server for remote IEx shells.

  This is useful to avoid the pitfalls with using disterl for many embedded device scenarios.

  IExSshShell provides a simple OTP application which runs an SSH server for remote IEx shells.

  This is useful to avoid the pitfalls with using disterl for many embedded device scenarios.

  Configuration is handled by settings `:iex_ssh_shell` configuration options in your project's config.exs.

  Example:

  ```elixir
  config :iex_ssh_shell,
  system_dir: "/etc/ssh",
  port: 2222,
  authorized_keys: [
  "ssh-rsa ... ",
  "ssh-rsa ... ",
  ...
  ]

  ```


  """

end
