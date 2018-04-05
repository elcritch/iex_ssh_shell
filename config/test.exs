
use Mix.Config

config :iex_ssh_shell,
  system_dir: './test/ssh/',
  authorized_keys: [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCmtCjHFLiURT1MChIDg4Q2VsEEhEmE3qh7poiqJPNN0UxHEI7k5RCV1ku/738JE9XPj7ERlxS7KG9whaqahTmoKAxXYZ4+nWvbdPx5hm40ZMxfvM0XHFZNUbU0p7c8q6FL56P/0nC3RLODGY6fd4m/jm5r+kCa3uhmK73Vzg9DHKAkzxip521uX3+VS9s4FF6nc8eZh0PQR791q6FNuisr64baTXvoyl/HaJ4XREpryl64f3fTh4mH4WogaiApsF7D5OpmO06nE9hHyTpXdojYx71A2ntDwmMsc/OfyDbEd56KFWVq/76ClzSQ1mHi+8iCdfR3Mpl4afitEnvhv8ZX test@example.com "
  ]

