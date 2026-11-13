-- QUERY 01: EVENT SUMMARY
-- Business question: Which website activities happen most often,
-- and how many distinct users perform each activity?

SELECT
    event_name,
    COUNT(*) AS total_events,
    COUNT(DISTINCT user_pseudo_id) AS unique_users
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
GROUP BY event_name
ORDER BY total_events DESC;


-- QUERY 02: SHOPPING EVENT SUMMARY
-- Business question: How many users view products, add items to cart,
-- begin checkout and make purchases?

SELECT
    event_name,
    COUNT(*) AS total_events,
    COUNT(DISTINCT user_pseudo_id) AS unique_users
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
  AND event_name IN ('view_item', 'add_to_cart', 'begin_checkout', 'purchase')
GROUP BY event_name
ORDER BY CASE event_name
    WHEN 'view_item' THEN 1
    WHEN 'add_to_cart' THEN 2
    WHEN 'begin_checkout' THEN 3
    WHEN 'purchase' THEN 4
END;


-- QUERY 03: REVENUE BY DEVICE
-- Business question: Which device category generates the highest revenue?

SELECT
    device.category AS device,
    COUNT(*) AS purchase_events,
    COUNT(DISTINCT user_pseudo_id) AS purchasing_users,
    ROUND(SUM(ecommerce.purchase_revenue_in_usd), 2) AS revenue_usd
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
  AND event_name = 'purchase'
GROUP BY device
ORDER BY revenue_usd DESC;


-- QUERY 04: TOP 10 PRODUCTS BY REVENUE
-- Business question: Which ten products generate the highest revenue,
-- and how many units of each product were sold?

SELECT
    item.item_name,
    SUM(item.quantity) AS units_sold,
    ROUND(SUM(item.item_revenue_in_usd), 2) AS revenue_usd
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(items) AS item
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
  AND event_name = 'purchase'
GROUP BY item.item_name
ORDER BY revenue_usd DESC
LIMIT 10;


-- QUERY 05: REVENUE BY PRODUCT CATEGORY
-- Business question: Which product categories generate the highest
-- revenue and sell the highest number of units?

SELECT
    COALESCE(item.item_category, 'Uncategorized') AS category,
    SUM(item.quantity) AS units_sold,
    ROUND(SUM(item.item_revenue_in_usd), 2) AS revenue_usd
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
UNNEST(items) AS item
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
  AND event_name = 'purchase'
GROUP BY category
ORDER BY revenue_usd DESC;


-- QUERY 06: MONTHLY REVENUE TREND
-- Business question: Which month generated the highest purchase revenue?

SELECT
    FORMAT_DATE('%Y-%m', PARSE_DATE('%Y%m%d', event_date)) AS sales_month,
    COUNT(*) AS purchase_events,
    COUNT(DISTINCT user_pseudo_id) AS purchasing_users,
    ROUND(SUM(ecommerce.purchase_revenue_in_usd), 2) AS monthly_revenue
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
  AND event_name = 'purchase'
GROUP BY sales_month
ORDER BY sales_month;


-- QUERY 07: TRAFFIC-SOURCE PERFORMANCE
-- Business question: Which first-acquisition sources are associated
-- with the most purchasing users and purchase revenue?

SELECT
    COALESCE(traffic_source.source, 'Not available') AS traffic_source,
    COUNT(*) AS purchase_events,
    COUNT(DISTINCT user_pseudo_id) AS purchasing_users,
    ROUND(SUM(ecommerce.purchase_revenue_in_usd), 2) AS revenue_usd
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
  AND event_name = 'purchase'
GROUP BY traffic_source
ORDER BY revenue_usd DESC
LIMIT 10;
