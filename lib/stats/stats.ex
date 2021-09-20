defmodule Stats.Stats do
  @filename "priv/rushing.json"

  def read_file() do
    File.read!(@filename)
    |> Jason.decode!()
  end

  @doc """
  Strip the possible "T" suffix on "Lng" values, convert to int, add as "Lng_Int".

  Note that some "Lng" fields in the data file are ints, not Strings.
  """
  def strip_lng_t_char(all) do
    all
    |> Enum.map(fn
      %{"Lng" => lng} = m when is_integer(lng) ->
        Map.put(
          m,
          "Lng_Int",
          lng)

      %{"Lng" => lng} = m when is_binary(lng) ->
        Map.put(
          m,
          "Lng_Int",
          String.replace_suffix(lng, "T", "") |> String.to_integer())
    end)
  end

end
