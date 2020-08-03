defmodule Jasonapi.ResourceTest do
  use ExUnit.Case

  alias Jasonapi.Resource

  defmodule UserResource do
    @behaviour Resource

    @impl true
    def id(struct), do: struct.id

    @impl true
    def type(_struct), do: "person"
  end

  defmodule User do
    def id, do: "123"
  end

  defmodule CarResource do
    @behaviour Resource

    @impl true
    def id(struct), do: struct.id

    @impl true
    def type(_struct), do: "motor-vehicle"

    @impl true
    def meta(struct), do: %{drivers: struct.num_drivers}
  end

  defmodule Car do
    def id, do: "345"

    def num_drivers, do: 5
  end

  defmodule FarmResource do
    @behaviour Resource

    @impl true
    def id(data), do: data.id

    @impl true
    def type(_data), do: "farm"

    @impl true
    def attributes(data) do
      %{specialty: data.specialty}
    end
  end

  defmodule Farm do
    def id, do: "mr8"

    def specialty, do: "chickens"
  end

  defmodule CragResource do
    @behaviour Resource

    @impl true
    def id(datum), do: datum.id

    @impl true
    def type(_datum), do: "crag"

    @impl true
    def attributes(datum) do
      %{name: datum.name}
    end

    @impl true
    def links(datum) do
      %{
        self: "http://example.com/crag/#{datum.id}",
        related: %{
          href: "http://example.com/maps?crag=#{datum.id}"
        }
      }
    end
  end

  defmodule Crag do
    def id, do: "987"

    def name, do: "Niagara Glen"
  end

  defmodule CompanyResource do
    @behaviour Resource

    @impl true
    def id(d), do: d.id

    @impl true
    def type(_), do: "company"

    @impl true
    def attributes(d), do: %{name: d.name}

    @impl true
    def relationships(data) do
      %{
        athletes: %{
          links: %{
            self: "http://example.com/company/#{data.id}/relationships/athletes"
          }
        }
      }
    end
  end

  defmodule Company do
    def id, do: "88u7uy7"

    def name, do: "Evolv"
  end

  describe "#to_map" do
    test "can return the simples possible allowed value" do
      ro = Resource.to_map(UserResource, User)

      assert ro == %{
        id: "123",
        type: "person"
      }
    end

    test "supports meta" do
      ro = Resource.to_map(CarResource, Car)

      assert ro == %{
        id: "345",
        type: "motor-vehicle",
        meta: %{
          drivers: 5
        }
      }
    end

    test "supports attributes" do
      ro = Resource.to_map(FarmResource, Farm)

      assert ro == %{
        id: "mr8",
        type: "farm",
        attributes: %{
          specialty: "chickens"
        }
      }
    end

    test "supports links" do
      ro = Resource.to_map(CragResource, Crag)

      assert ro == %{
        id: "987",
        type: "crag",
        attributes: %{name: "Niagara Glen"},
        links: %{
          self: "http://example.com/crag/987",
          related: %{
            href: "http://example.com/maps?crag=987"
          }
        }
      }
    end

    test "supports relationships" do
      ro = Resource.to_map(CompanyResource, Company)

      assert ro == %{
        id: "88u7uy7",
        type: "company",
        attributes: %{
          name: "Evolv"
        },
        relationships: %{
          athletes: %{
            links: %{
              self: "http://example.com/company/88u7uy7/relationships/athletes"
            }
          }
        }
      }
    end
  end
end