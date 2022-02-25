defmodule Inmana.Supplies.ExpirationNotificationTest do
  use Inmana.DataCase, async: true

  import Inmana.Factory

  alias Inmana.Supplies.ExpirationNotification

  describe "send/0" do
    test "when parameters are valid, create a new email" do
      build(:supply)

      response = ExpirationNotification.send()

      assert response == :ok
    end
  end
end
