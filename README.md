# Stats

Viewer for json file of various NFL stats.

# Notes

Screenshots are in `priv/screenshots`. 

Searching by a given field will maintain that search key
in the query string in the URL.

In the input file (`priv/rushing.json`), some of the fields
to sort on are ints, and some are strings. That's accounted
for in the code. Since I have to sort on the int fields,
I add a new key (e.g., `Yds_Int`) and int value on which
I do the sorting, but then just use the original key/value,
whether int or string, for display.

Default sort is on *Player* last name.


# Files

* `stats_web/router.ex` - Routing
* `stats_web/controllers/page_controller.ex` - Main logic
* `stats/stats.ex` - helper functions
* `stats_web/templates/page/index.html.eex` - Output template
* `test/stats/stats_test.exs` - Brief testing. If had more time,
would add more, of course.
* `priv/rushing.json` - Input file
* `priv/screenshots/` - Example output for different sorts
