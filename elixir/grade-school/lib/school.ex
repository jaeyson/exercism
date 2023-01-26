defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @type school :: any()

  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new, do: %{}

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
    names_per_grade = school[grade] || []

    case name in roster(school) do
      true ->
        {:error, school}

      false ->
        names_per_grade = Enum.sort([name | names_per_grade])
        school = Map.put(school, grade, names_per_grade)
        {:ok, school}
    end
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade), do: Map.get(school, grade, []) |> Enum.sort()

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school), do: Map.values(school) |>List.flatten()
end
