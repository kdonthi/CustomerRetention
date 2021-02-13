# CustomerRetention

The initial `data` table has the two columns (contains data from `data.sql`): 
  1. `id` → The user id. This is a unique identifier for a user
  2. `timestamp` → The timestamp of an event performed by the given user
 
After ```retention.sql``` is run, the data table called `users` is created. A .csv file of the `users` table is found in `output.csv`.

The output data table helps us understand acquisition cohort retention, which groups users into cohorts based on their start week, and shows what percent of users from a given week are still using the product. 
