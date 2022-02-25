defmodule Inmana.Supplies.SchedulerTest do
  use Inmana.DataCase

  alias Inmana.Supplies.Scheduler

  describe "start_link/1" do
    test "when parameters are valid, create a new email" do
      response = Scheduler.start_link(%{})

      assert {:ok, _pid} = response
    end
  end
end
