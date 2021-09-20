defmodule Stats.StatsTest do
  use ExUnit.Case

  test "strip_lng_t_char" do
    all = [
      %{
        "dummy" => 23,
        "Lng" => "42"
      },
      %{
        "dummy" => 24,
        "Lng" => "43T"
      },
      # Some maps in the data file has "Lng" as int
      %{
        "dummy" => 25,
        "Lng" => 44
      }
    ]

    expected = [
      %{
        "dummy" => 23,
        "Lng" => "42",
        "Lng_Int" => 42
      },
      %{
        "dummy" => 24,
        "Lng" => "43T",
        "Lng_Int" => 43
      },
      %{
        "dummy" => 25,
        "Lng" => 44,
        "Lng_Int" => 44
      }
    ]

    assert Stats.Stats.strip_lng_t_char(all) == expected
  end
end
