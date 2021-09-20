defmodule StatsWeb.PageController do
  use StatsWeb, :controller

  alias Stats.Stats

  @sort_key "sort_by"
  @sort_by_total_rushing_yards "Yds"
  @sort_by_total_rushing_touchdowns "TD"
  @sort_by_longest_rush "Lng"
  @sort_by_default_sort "Player"

  def index(conn, _params) do
    conn = Plug.Conn.fetch_query_params(conn)

    # Can sort by: Yds, TD, Lng
    sort_key =
      case conn.query_params[@sort_key] do
        key when key in [
          @sort_by_total_rushing_yards,
          @sort_by_total_rushing_touchdowns,
          @sort_by_longest_rush
        ] ->
          key

        _ ->
          @sort_by_default_sort
      end

    out = Stats.read_file()

    # TODO: add "sort direction" toggle in UI
    out = case sort_key do
      # Reverse sort
      @sort_by_total_rushing_yards ->
        out = Stats.string_nums_to_ints(out, "Yds", "Yds_Int")
        Enum.sort(out, fn %{"Yds_Int" => val1}, %{"Yds_Int" => val2} ->
          val1 >= val2 end)

      # Reverse sort
      @sort_by_total_rushing_touchdowns ->
        out = Stats.string_nums_to_ints(out, "TD", "TD_Int")
        Enum.sort(out, fn %{"TD_Int" => val1}, %{"TD_Int" => val2} ->
          val1 >= val2 end)

      # Strip "T" is present, convert to int, and then reverse sort
      @sort_by_longest_rush ->
        out = Stats.strip_lng_t_char(out)
        Enum.sort(out, fn %{"Lng_Int" => val1}, %{"Lng_Int" => val2} ->
          val1 >= val2 end)

      # Otherwise (no sort_key, or it's unknown) forward sort by name ("Player")
      _ ->
        Enum.sort_by(out,
          fn %{@sort_by_default_sort => name} ->
            String.split(name) |> List.last()
          end)
    end

    render(conn, "index.html", out: out, sort_key: sort_key)
  end
end
