CREATE TABLE currweek (
		id text,
		currweek int
		);

CREATE TABLE joinweek (
		id text,
		joinweek int
		);

CREATE TABLE joinandcurrweek (
		id text,
		joinweek int,
		currweek int
		);

CREATE TABLE intermediate (
		cohort int,
		week int,
		weekly_active_users int,
		weeks_since_signup int
		);

CREATE TABLE joinweekcount (
		joinweek int,
		signup_per_week int
		);

CREATE TABLE users (
		cohort int,
		week int,
		weekly_active_users int,
		weeks_since_signup int,
		total_signups_per_cohort int,
		pct_active numeric
		);

INSERT INTO currweek (id, currweek) (
		SELECT id, EXTRACT(WEEK FROM timestamp) 
		FROM data 
		GROUP BY id, EXTRACT(WEEK FROM timestamp)
		);

INSERT INTO joinweek (id, joinweek) (
		SELECT id, MIN(currweek) 
		FROM currweek 
		GROUP BY id
		);

INSERT INTO joinandcurrweek (id, joinweek, currweek) (
		SELECT joinweek.id, joinweek.joinweek, currweek.currweek
		FROM joinweek JOIN currweek ON joinweek.id = currweek.id
		);

INSERT INTO joinweekcount (joinweek, signup_per_week) (
		SELECT joinweek, COUNT(id) 
		FROM joinweek
		GROUP BY joinweek
		);

INSERT INTO intermediate (cohort, week, weekly_active_users, weeks_since_signup) (
		SELECT joinweek, currweek, COUNT(id), currweek - joinweek
		FROM joinandcurrweek GROUP BY joinweek, currweek
		);

INSERT INTO users (cohort, week, weekly_active_users, weeks_since_signup, total_signups_per_cohort, pct_active) (
		SELECT intermediate.cohort, intermediate.week, intermediate.weekly_active_users, intermediate.weeks_since_signup, joinweekcount.signup_per_week, ROUND((intermediate.weekly_active_users::numeric/joinweekcount.signup_per_week)*100,2) 
		FROM intermediate JOIN joinweekcount ON intermediate.cohort = joinweekcount.joinweek
		);


