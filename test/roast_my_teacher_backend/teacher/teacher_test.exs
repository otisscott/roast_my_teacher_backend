defmodule RMT.TeacherTest do
  use RMT.DataCase

  alias RMT.Teacher

  describe "roasts" do
    alias RMT.Teacher.Roasts

    @valid_attrs %{comment: "some comment", rating: 42}
    @update_attrs %{comment: "some updated comment", rating: 43}
    @invalid_attrs %{comment: nil, rating: nil}

    def roasts_fixture(attrs \\ %{}) do
      {:ok, roasts} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Teacher.create_roasts()

      roasts
    end

    test "list_roasts/0 returns all roasts" do
      roasts = roasts_fixture()
      assert Teacher.list_roasts() == [roasts]
    end

    test "get_roasts!/1 returns the roasts with given id" do
      roasts = roasts_fixture()
      assert Teacher.get_roasts!(roasts.id) == roasts
    end

    test "create_roasts/1 with valid data creates a roasts" do
      assert {:ok, %Roasts{} = roasts} = Teacher.create_roasts(@valid_attrs)
      assert roasts.comment == "some comment"
      assert roasts.rating == 42
    end

    test "create_roasts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Teacher.create_roasts(@invalid_attrs)
    end

    test "update_roasts/2 with valid data updates the roasts" do
      roasts = roasts_fixture()
      assert {:ok, roasts} = Teacher.update_roasts(roasts, @update_attrs)
      assert %Roasts{} = roasts
      assert roasts.comment == "some updated comment"
      assert roasts.rating == 43
    end

    test "update_roasts/2 with invalid data returns error changeset" do
      roasts = roasts_fixture()
      assert {:error, %Ecto.Changeset{}} = Teacher.update_roasts(roasts, @invalid_attrs)
      assert roasts == Teacher.get_roasts!(roasts.id)
    end

    test "delete_roasts/1 deletes the roasts" do
      roasts = roasts_fixture()
      assert {:ok, %Roasts{}} = Teacher.delete_roasts(roasts)
      assert_raise Ecto.NoResultsError, fn -> Teacher.get_roasts!(roasts.id) end
    end

    test "change_roasts/1 returns a roasts changeset" do
      roasts = roasts_fixture()
      assert %Ecto.Changeset{} = Teacher.change_roasts(roasts)
    end
  end
end
