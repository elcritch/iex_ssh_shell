# IExSshShell


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

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `iex_ssh_shell` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:iex_ssh_shell, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/iex_ssh_shell](https://hexdocs.pm/iex_ssh_shell).

