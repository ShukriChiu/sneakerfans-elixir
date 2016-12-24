defmodule SneakerfansElixir.HeroResolver do
  def all(_args, _info) do
    {:ok, [
      %{
        name: "Genji",
        country: "Japan"
      },
      %{
        name: "Mei",
        country: "China"
      }
    ]}
  end
end