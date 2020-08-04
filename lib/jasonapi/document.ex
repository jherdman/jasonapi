defmodule Jasonapi.Document do
  @moduledoc """
  Construct top-level JSON:API document objects
  """

  alias Jasonapi.Resource

  @typedoc """
  A top level JSON:API document

  https://jsonapi.org/format/#document-top-level
  """
  @type document :: %{
    optional(:data) => Resource.resource_object() | [Resource.resource_object()]
  }

  @doc """
  Produces a top-level JSON:API `"data"` document
  """
  @spec to_data_document(module(), Resource.datum()) :: document()
  def to_data_document(resource, datum) do
    %{data: Resource.to_map(resource, datum)}
  end
end