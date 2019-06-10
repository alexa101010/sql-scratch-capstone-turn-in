SELECT COUNT(DISTINCT utm_campaign) AS 'campaign count'
FROM page_visits;

SELECT COUNT(DISTINCT utm_source) AS 'source count'
FROM page_visits;

SELECT utm_campaign, 
	utm_source
FROM page_visits
GROUP BY 1;

SELECT DISTINCT page_name
FROM page_visits;

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) AS first_touch_at
    FROM page_visits
    GROUP BY 1)
SELECT COUNT (DISTINCT ft.user_id) AS 'number of first touch users',
        pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY 2
ORDER BY 1 DESC;

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) AS last_touch_at
    FROM page_visits
    GROUP BY 1)
SELECT COUNT (DISTINCT lt.user_id) AS 'number of last touch users',
        pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY 2
ORDER BY 1 DESC;

SELECT page_name, 
		COUNT (DISTINCT user_id)
FROM page_visits
GROUP BY 1;

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) AS last_touch_at
    FROM page_visits
  	WHERE page_name = '4 - purchase'
    GROUP BY 1)
SELECT count (DISTINCT lt.user_id) AS 'number of last touch users',
      	pv.utm_campaign,
      page_name
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY 2
ORDER BY 1 DESC;
