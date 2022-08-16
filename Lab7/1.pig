/**
 * Write a Pig Latin query that outputs the login of all users in NY state. (local mode)
 *
 * As input it will read from a CSV file that contains descriptions about users.
 * Each line in the user collection contains: login, name and state from a specific user.
 */

-- Use the PigStorage function to load the user collection file into the raw bag as an array of records.
-- Input: (login, name, state)
raw = LOAD 'users.csv' USING PigStorage(',') AS (login:chararray, name:chararray, state:chararray);

-- Use the FILTER command to remove all records with a state which is not NY.
users_in_NY = FILTER raw BY state matches 'NY';-- we can use eq in place of matches

-- Use the FOREACH-GENERATE command to project login field from relation users_in_NY to relation login_of_users_in_NY.
login_of_users_in_NY = FOREACH users_in_NY GENERATE login;

-- Use the default Pig output function to store the results.
STORE login_of_users_in_NY INTO '1.result';--stores in a file
--DUMP login_of_users_in_NY;--shows on terminal
