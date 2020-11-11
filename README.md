# IExSshShell


IExSshShell provides a simple OTP application which runs an SSH server for remote IEx shells.

This is useful to avoid the pitfalls with using disterl for many embedded device scenarios.

Configuration is handled by settings `:iex_ssh_shell` configuration options in your project's config.exs. 

Example:

```elixir
config :iex_ssh_shell,
  port: 2222,
  authorized_keys: [
    "ssh-rsa ... ",
    "ssh-rsa ... ",
    ...
  ]

```

## Security Warning! 

There is an option for `:iex_ssh_shell` to set the system directory for where to find the unique ssh key for each device. 

It'll default to the private dir for the repo: `:code.priv_dir(:iex_ssh_shell)` which is useful for testing and quick development, however it's best to setup a unique key per device: 

```
config :iex_ssh_shell,
  system_dir: :code.priv_dir(:my_app)
```

As far as I know, reusing the same key isn't a major security hole as each ssh session negotiates a per session encryption key. 


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

