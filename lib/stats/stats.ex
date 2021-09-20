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
        tmp = String.replace_suffix(lng, "T", "")
        tmp = Regex.replace(~r/\D/, tmp, "") |> String.to_integer()
        Map.put(
          m,
          "Lng_Int",
          tmp)
    end)
  end

  @doc """
  Convert the value of `key_in` to int if it's a string, and add to map
  as `key_out`.

  NOTE: this could be refafctored better if more time, as duplicate code with the Lng
  function above.
  """
  def string_nums_to_ints(all, key_in, key_out) do
    all
    |> Enum.map(fn
      %{^key_in => in_val} = m when is_integer(in_val) ->
        Map.put(
          m,
          key_out,
          in_val)

      %{^key_in => in_val} = m when is_binary(in_val) ->
        tmp = Regex.replace(~r/\D/, in_val, "") |> String.to_integer()
        Map.put(
          m,
          key_out,
          tmp)
    end)
  end
end
