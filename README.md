# datapipe2
zero to one for moving data

## Why
Do you need to get data from one database to another? Move data from a CSV
file into a database.

Then, move this data on a semi-regular basis.

And all this before you know whether its useful?

## How
You can call this on a single line,

  csv_to_db './data/test.csv', 'test_tbl'

Or, you can put it in a DSL and have it run on a scheduled basis.

  DB=pgsql://testuser:testpass@localhost/datapipe2 \
  Bcs_CRON="* * * * *" \
  datapipe2

## What
Check the lib and examples directories for available functions.
