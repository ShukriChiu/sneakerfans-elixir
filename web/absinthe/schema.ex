defmodule SneakerfansElixir.Schema do
  use Absinthe.Schema
  import_types SneakerfansElixir.Schema.Types

  query do
    field :heroes, list_of(:hero) do
      resolve &SneakerfansElixir.HeroResolver.all/2
    end
  end

end