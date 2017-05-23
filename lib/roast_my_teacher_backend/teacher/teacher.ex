defmodule RMT.Teacher do
  @moduledoc """
  The boundary for the Teacher system.
  """

  import Ecto.Query, warn: false
  alias RMT.Repo

  alias RMT.Teacher.Roasts
  alias RMT.Models.Teacher

  @doc """
  Returns the list of roasts.

  ## Examples

      iex> list_roasts(1)
      [%Roasts{}, ...]

  """
  def list_roasts(teacher_id) do
    Repo.all(from t in Teacher, where: t.id == ^teacher_id)
  end

  @doc """
  Gets a single roasts.

  Raises `Ecto.NoResultsError` if the Roasts does not exist.

  ## Examples

      iex> get_roasts!(123)
      %Roasts{}

      iex> get_roasts!(456)
      ** (Ecto.NoResultsError)

  """
  def get_roasts!(id), do: Repo.get!(Roasts, id)

  @doc """
  Creates a roasts.

  ## Examples

      iex> create_roasts(%{field: value})
      {:ok, %Roasts{}}

      iex> create_roasts(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_roasts(teacher_id, attrs \\ %{}) do
    Repo.get(Teacher, teacher_id)
      |> Ecto.build_assoc(:roasts)
      |
    %Roasts{}
    |> Roasts.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a roasts.

  ## Examples

      iex> update_roasts(roasts, %{field: new_value})
      {:ok, %Roasts{}}

      iex> update_roasts(roasts, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_roasts(%Roasts{} = roasts, attrs) do
    roasts
    |> Roasts.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Roasts.

  ## Examples

      iex> delete_roasts(roasts)
      {:ok, %Roasts{}}

      iex> delete_roasts(roasts)
      {:error, %Ecto.Changeset{}}

  """
  def delete_roasts(%Roasts{} = roasts) do
    Repo.delete(roasts)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking roasts changes.

  ## Examples

      iex> change_roasts(roasts)
      %Ecto.Changeset{source: %Roasts{}}

  """
  def change_roasts(%Roasts{} = roasts) do
    Roasts.changeset(roasts, %{})
  end
end
