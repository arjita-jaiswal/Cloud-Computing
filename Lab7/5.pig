/*Write a Pig Latin query that returns the number of tweets for each user name (not login). (local mode)*/
REGISTER pig-0.17.0-core-h2.jar;

users = LOAD 'users.csv' USING PigStorage(',') AS (login:chararray, name:chararray, state:chararray);
tweets = LOAD 'tweets.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage() AS (id:long, content:chararray, user:chararray
users_join_tweets = JOIN users BY login LEFT, tweets BY user;

name_group = GROUP users_join_tweets BY name;
number_of_tweets = FOREACH name_group GENERATE group, COUNT(users_join_tweets.id);
STORE number_of_tweets INTO '5.result' USING PigStorage (',');

/**
 * Write a Pig Latin query that returns the number of tweets for each user name (not login), ordered from most active to least active users. (local mode)
 *
 * As input it will read from two CSV files that contain descriptions about users and tweets, respectively.
 * Each line in the user collection contains: login, name and state from a specific user.
 * Each line in the collection of tweets has the tweet id, content, and a reference to the user who wrote that tweet.
 *
 * Output one user per line, in the following format:
 *     	user_name, number_of_tweets
 */

REGISTER piggybank.jar;

-- Use the PigStorage function to load the user collection file into the raw bag as an array of records.
-- Input: (login, name, state)
users = LOAD 'users.csv' USING PigStorage(',') AS (login:chararray, name:chararray, state:chararray);

-- Use the PigStorage function to load the tweets collection file into the raw bag as an array of records.
-- Input: (id, content, user)
tweets = LOAD 'tweets.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage() AS (id:long, content:chararray, user:chararray);

-- Performs an outer join of two relations based on common field values.
users_join_tweets = JOIN users BY login LEFT, tweets BY user;

name_group = GROUP users_join_tweets BY name;
number_of_tweets = FOREACH name_group GENERATE group, COUNT(users_join_tweets.id) as number;
order_number_of_tweets = ORDER number_of_tweets BY number DESC;

-- Use the default Pig output function to store the results.
STORE order_number_of_tweets INTO '3b.result' USING PigStorage (',');
