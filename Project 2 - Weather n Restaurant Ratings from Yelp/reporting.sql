USE SCHEMA DWH;

SELECT B.name AS business_name
    , T.temp_avg as temperature
    , P.precipitation as precipitation
    , F.stars as ratings
FROM FACT_RESTAURANT_REVIEWS F 
LEFT JOIN DIM_BUSINESS B 
ON F.business_id = B.business_id
LEFT JOIN DIM_TEMPERATURE T 
ON T.DAY = F.DATE 
LEFT JOIN DIM_PRECIPITATION P 
ON P.DAY = F.DATE 
