-- CREATE AND INSERT INTO ODS TABLES
use UDACITY;
use schema ODS;


-- business
CREATE TABLE  business (
    business_id STRING,
    name STRING,
    address STRING,
    city STRING,
    review_count NUMBER,
    stars NUMBER,
    state STRING,
    PRIMARY KEY (business_id)
);

INSERT INTO business SELECT jsoncolumn:business_id
, jsoncolumn:name
, jsoncolumn:address
, jsoncolumn:city
, jsoncolumn:review_count
, jsoncolumn:stars
, jsoncolumn:state
FROM UDACITY.STAGING.BUSINESS;

--checkin
CREATE TABLE  checkin (
    business_id STRING,
    date STRING,

);

INSERT INTO checkin SELECT jsoncolumn:business_id
, jsoncolumn:date
FROM UDACITY.STAGING.checkin;

--review
CREATE TABLE  review (
    business_id STRING,
    review_id STRING,
    date STRING,
    user_id STRING,
    stars NUMBER,
    PRIMARY KEY (review_id)

);

INSERT INTO review SELECT jsoncolumn:business_id
, jsoncolumn:review_id
, jsoncolumn:date
, jsoncolumn:user_id
, jsoncolumn:stars
FROM UDACITY.STAGING.review;

--tip
CREATE TABLE  tip (
    business_id STRING,
    date STRING,
    compliment_count NUMBER,
    user_id STRING

);
INSERT INTO tip SELECT jsoncolumn:business_id
, jsoncolumn:date
, jsoncolumn:compliment_count
, jsoncolumn:user_id
FROM UDACITY.STAGING.tip;

-- user
CREATE TABLE  user (
    user_id STRING,
    name STRING,
    review_count NUMBER,
    PRIMARY KEY (user_id)
);

INSERT INTO user SELECT jsoncolumn:user_id
, jsoncolumn:name
, jsoncolumn:review_count
FROM UDACITY.STAGING.user;

--COVID 
CREATE TABLE covid (
    business_id STRING,
    covid_banner STRING,
    delivery_or_takeout STRING,
    temporary_closed_until STRING
);

INSERT INTO covid SELECT jsoncolumn:business_id
, jsoncolumn:"Covid Banner"
, jsoncolumn:"delivery or takeout"
, jsoncolumn:"Temporary Closed Until"
FROM UDACITY.STAGING.covid;


--TEMPERATURE
CREATE TABLE temperature (
    day DATE,
    temp_avg FLOAT,
    normal_val FLOAT,
    PRIMARY KEY (day)
);

INSERT INTO temperature SELECT 
DAY,
temp_avg,
normal_val
FROM UDACITY.STAGING.temperature;

--PRECIPITATION
CREATE TABLE precipitation (
    day DATE,
    precipitation FLOAT,
    normal_val FLOAT,
    PRIMARY KEY (day)
);

INSERT INTO precipitation SELECT 
DAY,
precipitation,
normal_val
FROM UDACITY.STAGING.precipitation;


--ADD FOREIGN KEY CONSTRAINT 
ALTER TABLE checkin 
ADD CONSTRAINT business_fk FOREIGN KEY (business_id) 
REFERENCES business (business_id)
ON DELETE CASCADE;

ALTER TABLE tip 
ADD CONSTRAINT business_fk FOREIGN KEY (business_id) 
REFERENCES business (business_id)
ON DELETE CASCADE,
ADD CONSTRAINT user_fk FOREIGN KEY (user_id) 
REFERENCES user (user_id)
ON DELETE CASCADE;

ALTER TABLE covid 
ADD CONSTRAINT business_fk FOREIGN KEY (business_id) 
REFERENCES business (business_id)
ON DELETE CASCADE;

ALTER TABLE review 
ADD CONSTRAINT business_fk FOREIGN KEY (business_id) 
REFERENCES business (business_id)
ON DELETE CASCADE,
ADD CONSTRAINT user_fk FOREIGN KEY (user_id) 
REFERENCES user (user_id)
ON DELETE CASCADE;

