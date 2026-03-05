{{
    config (
        materialized='table'
    )
}}

WITH bookings_source as (
    SELECT 
        booking_amount::INT AS booking_amount,
        booking_date::TIMESTAMP AS booking_date,
        booking_id::varchar AS booking_id,
        CLEANING_FEE::INT AS CLEANING_FEE,
        CREATED_AT::TIMESTAMP AS CREATED_AT,
        LISTING_ID::INT AS LISTING_ID,
        NIGHTS_BOOKED::INT AS NIGHTS_BOOKED,
        SERVICE_FEE::INT AS SERVICE_FEE,
        BOOKING_STATUS::varchar AS BOOKING_STATUS

    FROM
        AIRBNB_DB.STAGING.BOOKINGS
),

bookings_cleaned AS (
    SELECT 
        booking_id,
        EXTRACT(YEAR FROM booking_date) as booking_year,
        booking_date,
        NIGHTS_BOOKED,
        booking_amount,
        CLEANING_FEE,
        SERVICE_FEE,
        BOOKING_STATUS
    
    FROM bookings_source
    WHERE LOWER(BOOKING_STATUS) != 'cancelled'

)

SELECT * FROM bookings_cleaned