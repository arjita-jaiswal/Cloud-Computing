/**
 * Write a Pig Latin query that returns all the tweets that include the word 'favorite', ordered by tweet id. (local mode)
 *
 * As input it will read from a CSV file that contains descriptions about tweets.
 * Each line in the collection of tweets contains the tweet id, content, and a reference to the user who wrote that tweet.
 */

REGISTER pig-0.17.0-core-h2.jar;

-- Use the PigStorage function to load the tweets collection file into the raw bag as an array of records.
-- Input: (id, content, user)
raw = LOAD 'tweets.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage() AS (id:long, content:chararray, user:chararray);
--raw = LOAD 'tweets.csv' USING PigStorage(',') AS (id:long, content:chararray, user:chararray);--not finds all

-- Use the FILTER command to remove all tweets with a content which does not include the word 'favorite'.
tweets_include_favorite = FILTER raw BY (content matches '.*favorite.*');

-- Ordered by tweet id.
tweets_include_favorite_ordered_by_id = ORDER tweets_include_favorite BY id;

-- Use the default Pig output function to store the results.
STORE tweets_include_favorite_ordered_by_id INTO '2.result';
