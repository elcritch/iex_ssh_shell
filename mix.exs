defmodule IExSshShell.MixProject do
  use Mix.Project

  @version "0.1.0"

  @description """
  Starts a SSH daemon that provides a remote IEx shell.
  """

  def project do
    [
      app: :iex_ssh_shell,
      version: @version,
      description: @description,
      elixir: "~> 1.6",
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :public_key, :ssh],
      mod: {IExSshShell.Application, []}
    ]
  end

  defp package do
    [
      maintainers: ["Jaremy Creechley <creechley@gmail.com>"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/elcritch/iex_ssh_shell"},
      files: ["lib/", "priv/", "README", "mix.exs", "config/"]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
    ]
  end
end
