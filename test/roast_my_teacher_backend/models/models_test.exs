defmodule RMT.ModelsTest do
  use RMT.DataCase

  alias RMT.Models

  describe "teachers" do
    alias RMT.Models.Teacher

    @valid_attrs %{name: "some name", subject: "some subject"}
    @update_attrs %{name: "some updated name", subject: "some updated subject"}
    @invalid_attrs %{name: nil, subject: nil}

    def teacher_fixture(attrs \\ %{}) do
      {:ok, teacher} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Models.create_teacher()

      teacher
    end

    test "list_teachers/0 returns all teachers" do
      teacher = teacher_fixture()
      assert Models.list_teachers() == [teacher]
    end

    test "get_teacher!/1 returns the teacher with given id" do
      teacher = teacher_fixture()
      assert Models.get_teacher!(teacher.id) == teacher
    end

    test "create_teacher/1 with valid data creates a teacher" do
      assert {:ok, %Teacher{} = teacher} = Models.create_teacher(@valid_attrs)
      assert teacher.name == "some name"
      assert teacher.subject == "some subject"
    end

    test "create_teacher/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Models.create_teacher(@invalid_attrs)
    end

    test "update_teacher/2 with valid data updates the teacher" do
      teacher = teacher_fixture()
      assert {:ok, teacher} = Models.update_teacher(teacher, @update_attrs)
      assert %Teacher{} = teacher
      assert teacher.name == "some updated name"
      assert teacher.subject == "some updated subject"
    end

    test "update_teacher/2 with invalid data returns error changeset" do
      teacher = teacher_fixture()
      assert {:error, %Ecto.Changeset{}} = Models.update_teacher(teacher, @invalid_attrs)
      assert teacher == Models.get_teacher!(teacher.id)
    end

    test "delete_teacher/1 deletes the teacher" do
      teacher = teacher_fixture()
      assert {:ok, %Teacher{}} = Models.delete_teacher(teacher)
      assert_raise Ecto.NoResultsError, fn -> Models.get_teacher!(teacher.id) end
    end

    test "change_teacher/1 returns a teacher changeset" do
      teacher = teacher_fixture()
      assert %Ecto.Changeset{} = Models.change_teacher(teacher)
    end
  end
end
