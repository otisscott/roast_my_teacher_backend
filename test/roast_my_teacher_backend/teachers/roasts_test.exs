defmodule RMT.RoastsTest do
  use RMT.DataCase

  alias RMT.Teachers.Roasts

  describe "roasts" do
    alias RMT.Models.{Roast, Teacher}

    @valid_attrs %{comment: "albinson sucks", rating: 0}
    @update_attrs %{comment: "albinson is great", rating: 0}
    @invalid_attrs %{comment: "", rating: 6}

    def roast_fixture(attrs \\ %{}) do
      teacher = mock_teacher
      {:ok, roast} = attrs
        |> Enum.into(@valid_attrs)
        |> Roasts.create_roast(teacher)

      %{roast: roast, teacher: teacher}
    end

    test "list_roasts/0 returns all roasts" do
      %{teacher: teacher, roast: roast} = roast_fixture()
      assert Roasts.list_roasts(teacher.id) == [roast]
    end

    test "get_roast!/1 returns the roast with given id" do
      %{roast: roast} = roast_fixture()
      assert Roasts.get_roast!(roast.id) == roast
    end

    test "create_roast/1 with valid data creates a roast" do
      assert {:ok, %Roast{} = roast} = Roasts.create_roast(@valid_attrs, mock_teacher)
      assert roast.comment == @valid_attrs.comment
      assert roast.rating == @valid_attrs.rating
    end

    test "create_roast/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Roasts.create_roast(@invalid_attrs, mock_teacher)
    end

    test "update_roast/2 with valid data updates the roast" do
      %{roast: roast} = roast_fixture()
      assert {:ok, roast} = Roasts.update_roast(roast, @update_attrs)
      assert %Roast{} = roast
      assert roast.comment == @update_attrs.comment
      assert roast.rating == @update_attrs.rating
    end

    test "update_roast/2 with invalid data returns error changeset" do
      %{roast: roast} = roast_fixture()
      assert {:error, %Ecto.Changeset{}} = Roasts.update_roast(roast, @invalid_attrs)
      assert roast == Roasts.get_roast!(roast.id)
    end

    test "delete_roast/1 deletes the roast" do
      %{roast: roast} = roast_fixture()
      assert {:ok, %Roast{}} = Roasts.delete_roast(roast)
      assert_raise Ecto.NoResultsError, fn -> Roasts.get_roast!(roast.id) end
    end

    test "change_roast/1 returns a roast changeset" do
      roast = roast_fixture()
      assert %Ecto.Changeset{} = Roasts.change_roast(roast)
    end
  end
end
