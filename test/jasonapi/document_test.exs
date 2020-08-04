defmodule Jasonapi.DocumentTest do
  use ExUnit.Case

  alias Jasonapi.{Car, CarResource, Document}

  describe "#to_data_document" do
    test "returns a map representing a data document" do
      doc = Document.to_data_document(CarResource, Car)

      assert %{data: resource_object} = doc
    end
  end
end