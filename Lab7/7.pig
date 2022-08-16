/**
 * Write a Pig Latin query that returns the name of users that posted at least two tweets. (local mode)
 *
 * As input it will read from two CSV files that contain descriptions about users and tweets, respectively.
 * Each line in the user collection contains: login, name and state from a specific user.
 * Each line in the collection of tweets has the tweet id, content, and a reference to the user who wrote that tweet.
 *
 * Output one user name per line.
 */

REGISTER pig-0.17.0-core-h2.jar;

-- Use the PigStorage function to load the user collection file into the raw bag as an array of records.
-- Input: (login, name, state)
users = LOAD 'users.csv' USING PigStorage(',') AS (login:chararray, name:chararray, state:chararray);

-- Use the PigStorage function to load the tweets collection file into the raw bag as an array of records.
-- Input: (id, content, user)
tweets = LOAD 'tweets.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage() AS (id:long, content:chararray, user:chararray);

users_join_tweets = JOIN users BY login, tweets BY user;

login_group = GROUP users_join_tweets BY (login, name);
number_of_tweets = FOREACH login_group GENERATE group, COUNT(users_join_tweets) as number;
at_least_two_tweets = FILTER number_of_tweets BY number > 1;
at_least_two_tweets_names = FOREACH at_least_two_tweets GENERATE group.name;

-- Use the default Pig output function to store the results.
STORE at_least_two_tweets_names INTO '7.result';
