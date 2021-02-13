# CustomerRetention

The goal of this ```retention.sql``` is to understand acquisition cohort retention, which groups users into cohorts based on their start week, and shows what percent of users from a given week are still using the product. 

The initial `data` table has the two columns (contains data from `data.sql`): 
 - `id` → The user id, which is a unique identifier for a user.
 - `timestamp` → The timestamp of an event performed by the given user. 
 
After ```retention.sql``` is run, the data table called `users` is created with the following columns: 
- `cohort`→ The ISO week that a group of users signed up
- `week`→ The ISO week of the year
- `weekly_active_users`→ The total number of users from **cohort** active in the given **week**
- `weeks_since_signup`→ The difference between week and cohort
- `total_signups_per_cohort`→ The total number of users who signed up in the given cohort week
- `pct_active`→ **weekly_active_users** / **total_signups_per_cohort** * 100 (rounded to 2 d.p.)

A .csv file of the `users` table is found in `output.csv`.

