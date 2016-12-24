defmodule SneakerfansElixir.Schema.Types do
  use Absinthe.Schema.Notation
  object :hero do
    field :name, :string
    field :country, :string
  end
end