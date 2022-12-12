use UDACITY;
use schema DWH;

--DIM_COVID 
CREATE TABLE DIM_COVID (
    business_id STRING,
    covid_banner STRING,
    delivery_or_takeout STRING,
    temporary_closed_until STRING
);

INSERT INTO DIM_COVID SELECT business_id
,covid_banner
,delivery_or_takeout
,temporary_closed_until
FROM UDACITY.ODS.covid;

-- DIM_BUSINESS
CREATE TABLE  DIM_BUSINESS (
    business_id STRING,
    name STRING,
    address STRING,
    city STRING,
    review_count NUMBER,
    stars NUMBER,
    state STRING,
    PRIMARY KEY (business_id)
);

INSERT INTO DIM_BUSINESS SELECT business_id ,
    name,
    address,
    city,
    review_count,
    stars,
    state 
FROM UDACITY.ODS.BUSINESS; 

--DIM_CHECKIN
CREATE TABLE  DIM_CHECKIN (
    business_id STRING,
    date DATE
);

INSERT INTO DIM_CHECKIN SELECT business_id,
    TRY_TO_DATE(date) 
FROM UDACITY.ODS.checkin;

--DIM_TIP
 
CREATE TABLE  DIM_TIP (
    business_id STRING,
    date  DATE,
    compliment_count NUMBER,
    user_id STRING

);
INSERT INTO DIM_TIP SELECT 
    business_id,
    TRY_TO_DATE(date),
    compliment_count,
    user_id
FROM UDACITY.ODS.tip;

-- DIM_USER
CREATE TABLE  DIM_USER (
    user_id STRING,
    name STRING,
    review_count NUMBER,
    PRIMARY KEY (user_id)
);

INSERT INTO DIM_USER SELECT 
    user_id,
    name,
    review_count
FROM UDACITY.ODS.user;

--DIM_TEMPERATURE
CREATE TABLE DIM_TEMPERATURE (
    day DATE,
    temp_avg FLOAT,
    normal_val FLOAT,
    PRIMARY KEY (day)
);

INSERT INTO DIM_TEMPERATURE SELECT 
DAY,
temp_avg,
normal_val
FROM UDACITY.ODS.temperature;

--DIM_PRECIPITATION
CREATE TABLE DIM_PRECIPITATION (
    day DATE,
    precipitation FLOAT,
    normal_val FLOAT,
    PRIMARY KEY (day)
);

INSERT INTO DIM_PRECIPITATION SELECT 
DAY,
precipitation,
normal_val
FROM UDACITY.ODS.precipitation;

--FACT_RESTAURANT_REVIEWS
CREATE TABLE FACT_RESTAURANT_REVIEWS (
    business_id STRING,
    user_id STRING,
    review_id STRING,
    date DATE,
    stars NUMBER,
    PRIMARY KEY (review_id)
);

INSERT INTO FACT_RESTAURANT_REVIEWS SELECT
     business_id,
     review_id,
     user_id,
     date,
     stars
FROM UDACITY.ODS.review; 

--ADD FOREIGN KEY CONSTRAINT
ALTER TABLE FACT_RESTAURANT_REVIEWS 
ADD CONSTRAINT business_fk FOREIGN KEY (business_id) 
REFERENCES dim_business (business_id)
ON DELETE CASCADE,
ADD CONSTRAINT user_fk FOREIGN KEY (user_id) 
REFERENCES dim_user (user_id)
ON DELETE CASCADE;

ALTER TABLE DIM_COVID 
ADD CONSTRAINT business_fk FOREIGN KEY (business_id) 
REFERENCES dim_business (business_id)
ON DELETE CASCADE;

ALTER TABLE dim_checkin 
ADD CONSTRAINT business_fk FOREIGN KEY (business_id) 
REFERENCES dim_business (business_id)
ON DELETE CASCADE;

ALTER TABLE dim_tip 
ADD CONSTRAINT business_fk FOREIGN KEY (business_id) 
REFERENCES dim_business (business_id)
ON DELETE CASCADE,
ADD CONSTRAINT user_fk FOREIGN KEY (user_id) 
REFERENCES dim_user (user_id)
ON DELETE CASCADE;
