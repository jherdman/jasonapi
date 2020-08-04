defmodule Jasonapi.CarResource do
  @moduledoc false

  @behaviour Jasonapi.Resource

  @impl true
  def id(struct), do: struct.id

  @impl true
  def type(_struct), do: "motor-vehicle"

  @impl true
  def meta(struct), do: %{drivers: struct.num_drivers}
end

defmodule Jasonapi.Car do
  @moduledoc false

  def id, do: "345"

  def num_drivers, do: 5
end