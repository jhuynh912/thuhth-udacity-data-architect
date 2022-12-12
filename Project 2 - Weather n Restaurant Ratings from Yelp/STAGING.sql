snowsql -a ji40557.ap-southeast-1 -u thuhth
use UDACITY;
use schema STAGING;

-- JSON file format and stage
create or replace file format myjsonformat type='JSON' strip_outer_array=True;
create or replace stage my_json_stage file_format = myjsonformat;

--CSV file format and stage
create or replace file format mycsvformat type='CSV' compression='auto' field_delimiter=',' record_delimiter = '\n' skip_header=1 error_on_column_count_mismatch=true null_if = ('NULL', 'null') empty_field_as_null = true;
create or replace stage my_csv_stage file_format = mycsvformat;

--create STAGING table
create table covid(jsoncolumn variant);
create table precipitation (day date, precipitation float, normal_val float);
create table temperature (day date, temp_avg float, normal_val float);
create table business (jsoncolumn variant);
create table checkin (jsoncolumn variant);
create table review (jsoncolumn variant);
create table tip (jsoncolumn variant);
create table user (jsoncolumn variant);


-- put file from local to stage area
put file://D:/Projects/udacity_DAR/Proj2/covid_features.json @my_json_stage auto_compress = true;
put file://D:/Projects/udacity_DAR/Proj2/precipitation.csv @my_csv_stage auto_compress = true;
put file://D:/Projects/udacity_DAR/Proj2/temperature.csv @my_csv_stage auto_compress = true;
put file://D:/Projects/udacity_DAR/Proj2/business.json @my_json_stage auto_compress = true;
put file://D:/Projects/udacity_DAR/Proj2/checkin.json @my_json_stage auto_compress = true;
put file://D:/Projects/udacity_DAR/Proj2/review.json @my_json_stage auto_compress = true;
put file://D:/Projects/udacity_DAR/Proj2/tip.json @my_json_stage auto_compress = true;
put file://D:/Projects/udacity_DAR/Proj2/user.json @my_json_stage auto_compress = true;

-- copy file from stage area to STAGING tables
copy into COVID from @my_json_stage/covid_features.json.gz file_format=myjsonformat on_error='skip_file';
copy into PRECIPITATIon from @my_csv_stage/precipitation.csv.gz file_format=mycsvformat on_error='continue'purge=true;
copy into temperature from @my_csv_stage/temperature.csv.gz file_format=mycsvformat on_error='continue' purge=true;
copy into business from @my_json_stage/business.json.gz file_format=myjsonformat on_error='skip_file';
copy into checkin from @my_json_stage/checkin.json.gz file_format=myjsonformat on_error='skip_file';
copy into tip from @my_json_stage/tip.json.gz file_format=myjsonformat on_error='skip_file';
copy into user from @my_json_stage/user.json.gz file_format=myjsonformat on_error='skip_file';
copy into review from @my_json_stage/review.json.gz file_format=myjsonformat on_error='skip_file';



--COUNT STAGING TABLES
SELECT 'covid' as tb_name , COUNT(*) FROM covid group by tb_name
UNION
SELECT 'precipitation' as tb_name ,COUNT(*) FROM precipitation group by tb_name
UNION
SELECT 'temperature' as tb_name ,COUNT(*) FROM temperature group by tb_name
UNION
SELECT 'business' as tb_name ,COUNT(*) FROM business group by tb_name
UNION
SELECT 'checkin' as tb_name ,COUNT(*) FROM checkin group by tb_name
UNION
SELECT 'review' as tb_name ,COUNT(*) FROM review group by tb_name
UNION
SELECT 'tip' as tb_name ,COUNT(*) FROM tip group by tb_name
UNION
SELECT 'user' as tb_name ,COUNT(*) FROM user group by tb_name