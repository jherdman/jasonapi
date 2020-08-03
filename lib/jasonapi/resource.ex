defmodule Jasonapi.Resource do
  @moduledoc """

  """

  @type t :: __MODULE__

  @typedoc """
  A map representation of a JSON:API resource object.

  https://jsonapi.org/format/#document-resource-objects
  """
  @type resource_object :: %{
    required(:id) => String.t(),
    required(:type) => String.t(),
    optional(:attributes) => map(),
    optional(:meta) => meta(),
    optional(:links) => map(),
    optional(:relationships) => map()
  }

  @typedoc """
  A meta object

  https://jsonapi.org/format/#document-meta
  """
  @type meta :: map()

  @typedoc """
  A `relationships` object

  https://jsonapi.org/format/#document-resource-object-relationships
  """
  @type relationships :: %{

  }

  @typedoc """
  A `links` object

  https://jsonapi.org/format/#document-links
  """
  @type links :: %{
    optional(atom()) => String.t(),
    optional(atom()) => %{
      optional(:href) => String.t(),
      optional(:meta) => meta()
    }
  }

  @typedoc """
  Datum is what you are turning into a Resource Object.
  """
  @type datum :: struct()

  @callback id(datum()) :: String.t()

  @callback type(datum()) :: String.t()

  @callback attributes(datum()) :: map()

  @callback links(datum()) :: links()

  @callback included(datum()) :: map()

  @callback meta(datum()) :: meta()

  @callback relationships(datum()) :: map()

  @optional_callbacks links: 1, included: 1, meta: 1, relationships: 1, attributes: 1

  @optional_keys [:attributes, :links, :meta]

  @doc """
  Converts some data into a map that represents a resource object using some
  implementation of the `Resource` behaviour.

  ## Example

      iex> to_map(UserResource, %{})
      %{id: some_id, type: some_type, ...}
  """
  @spec to_map(module(), datum()) :: resource_object()
  def to_map(impl, datum) do
    ro = %{
      id: impl.id(datum),
      type: impl.type(datum)
    }

    @optional_keys
    |> Enum.filter(& function_exported?(impl, &1, 1))
    |> Enum.reduce(ro, fn key, acc ->
      val = apply(impl, key, [datum])

      if is_nil(val) do
        acc
      else
        Map.put(acc, key, val)
      end
    end)
  end
end