# ElixirUno

This is a project to study about process comunication in elixir.
It is based on the Uno Game, where two NPC (Non player character) plays until some wins, a NPC Player is an elixir process that has its own PID and send messages to another process (NPC Player).

# Screenshots:

<img width="401" alt="Screen Shot 2022-04-23 at 10 18 56" src="https://user-images.githubusercontent.com/80367187/164896253-26172909-f835-4783-84f3-288821f779b3.png">

# Using

To run the program, you first need to have elixir installed and then you can use the following commands:

```bash
iex -S mix
```

Then in iex you run:

```elixir
ElixirUno.start
```

# Testing

To run test run the following command:

```bash
mix test
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `elixir_uno` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixir_uno, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/elixir_uno>.

