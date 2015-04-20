EctoIt
======

Library for simple integration tests for Ecto, which implements EctoIt.Repo module, which based on
MIX_ENV dispatch the call to related Postgres or Mysql database.

Usage:

```elixir
Application.ensure_all_started(:ecto_it)
```

Start of :ecto_it do storage_up and stop of :ecto_it do storage_down, in between your can use EctoIt.Repo for testing.
