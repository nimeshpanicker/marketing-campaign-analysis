CREATE TABLE marketing_campaign (
    campaign_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    ad_spend_inr NUMERIC(15,2),
    impressions BIGINT,
    clicks BIGINT,
    conversions BIGINT,
    revenue_inr NUMERIC(15,2),
    roi NUMERIC(10,2),
    campaign_date DATE,
    marketing_channel VARCHAR(100)
);

SELECT *
FROM marketing_campaign
LIMIT 10;

--1. What is the overall marketing performance?
SELECT
    COUNT(*) AS total_campaigns,
    CHR(8377) || ' ' || TO_CHAR(SUM(ad_spend_inr), 'FM99,99,99,990.00') AS total_ad_spend,
    CHR(8377) || ' ' || TO_CHAR(SUM(revenue_inr), 'FM99,99,99,990.00') AS total_revenue,
    CHR(8377) || ' ' || TO_CHAR(SUM(revenue_inr) - SUM(ad_spend_inr), 'FM99,99,99,990.00') AS total_profit,
    ROUND(((SUM(revenue_inr) - SUM(ad_spend_inr))
        / NULLIF(SUM(ad_spend_inr), 0)) * 100, 2) AS overall_roi_percent,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(conversions) AS total_conversions
FROM marketing_campaign;

--2. Which marketing channels generate the highest revenue?
SELECT
    marketing_channel,
    COUNT(*) AS campaigns,
    CHR(8377) || ' ' || TO_CHAR(SUM(revenue_inr), 'FM99,99,99,990.00') AS total_revenue
FROM marketing_campaign
GROUP BY marketing_channel
ORDER BY SUM(revenue_inr) DESC;

--3. Which marketing channels have the highest ROI?
SELECT
    marketing_channel,
    ROUND(((SUM(revenue_inr) - SUM(ad_spend_inr))
        / NULLIF(SUM(ad_spend_inr), 0)) * 100, 2) AS roi_percent
FROM marketing_campaign
GROUP BY marketing_channel
ORDER BY roi_percent DESC;

--4. Which category generates the highest revenue?
SELECT
    category,
    COUNT(*) AS campaigns,
    CHR(8377) || ' ' || TO_CHAR(SUM(revenue_inr), 'FM99,99,99,990.00') AS revenue
FROM marketing_campaign
GROUP BY category
ORDER BY SUM(revenue_inr) DESC;

--5. Which categories generate the highest profit?
SELECT
    category,
    CHR(8377) || ' ' || TO_CHAR(
        SUM(revenue_inr) - SUM(ad_spend_inr),
        'FM99,99,99,990.00'
    ) AS profit
FROM marketing_campaign
GROUP BY category
ORDER BY SUM(revenue_inr) - SUM(ad_spend_inr) DESC;

--6. What are the top 10 products by revenue?
SELECT
    product_name,
    COUNT(*) AS campaigns,
    CHR(8377) || ' ' || TO_CHAR(
        SUM(revenue_inr),
        'FM99,99,99,990.00'
    ) AS total_revenue
FROM marketing_campaign
GROUP BY product_name
ORDER BY SUM(revenue_inr) DESC
LIMIT 10;

--7. What are the top 10 products by ROI?
SELECT
    product_name,
    ROUND(((SUM(revenue_inr) - SUM(ad_spend_inr))
        / NULLIF(SUM(ad_spend_inr), 0)) * 100, 2) AS roi_percent
FROM marketing_campaign
GROUP BY product_name
ORDER BY roi_percent DESC
LIMIT 10;

--8. Which products have high revenue but relatively low ROI?
SELECT
    product_name,
    CHR(8377) || ' ' || TO_CHAR(SUM(revenue_inr), 'FM99,99,99,990.00') AS revenue,
    CHR(8377) || ' ' || TO_CHAR(SUM(ad_spend_inr), 'FM99,99,99,990.00') AS ad_spend,
    ROUND(((SUM(revenue_inr) - SUM(ad_spend_inr))
        / NULLIF(SUM(ad_spend_inr), 0)) * 100, 2) AS roi_percent
FROM marketing_campaign
GROUP BY product_name
HAVING SUM(revenue_inr) > 10000000
ORDER BY roi_percent ASC;

--9. Which campaigns generated the highest revenue?
SELECT
    campaign_id,
    product_name,
    marketing_channel,
    CHR(8377) || ' ' || TO_CHAR(ad_spend_inr, 'FM99,99,99,990.00') AS ad_spend,
    CHR(8377) || ' ' || TO_CHAR(revenue_inr, 'FM99,99,99,990.00') AS revenue,
    roi
FROM marketing_campaign
ORDER BY revenue_inr DESC
LIMIT 10;

--10. Which campaigns generated negative ROI?
SELECT
    campaign_id,
    product_name,
    marketing_channel,
    ad_spend_inr,
    revenue_inr,
    roi
FROM marketing_campaign
WHERE roi < 0
ORDER BY roi ASC;

--11. What is the monthly revenue and profit trend?
SELECT
    DATE_TRUNC('month', campaign_date)::DATE AS month,
    CHR(8377) || ' ' || TO_CHAR(SUM(revenue_inr), 'FM99,99,99,990.00') AS revenue,
    CHR(8377) || ' ' || TO_CHAR(
        SUM(revenue_inr) - SUM(ad_spend_inr),
        'FM99,99,99,990.00'
    ) AS profit
FROM marketing_campaign
GROUP BY 1
ORDER BY 1;

--12. Which month had the highest ROI?
SELECT
    DATE_TRUNC('month', campaign_date)::DATE AS month,
    ROUND(((SUM(revenue_inr) - SUM(ad_spend_inr))
        / NULLIF(SUM(ad_spend_inr), 0)) * 100, 2) AS roi_percent
FROM marketing_campaign
GROUP BY 1
ORDER BY roi_percent DESC;

--13. What is the overall marketing funnel performance?
SELECT
    SUM(impressions) AS impressions,
    SUM(clicks) AS clicks,
    SUM(conversions) AS conversions,
    ROUND(SUM(clicks) * 100.0 / NULLIF(SUM(impressions), 0), 2) AS ctr_percent,
    ROUND(SUM(conversions) * 100.0 / NULLIF(SUM(clicks), 0), 2) AS conversion_rate_percent
FROM marketing_campaign;

--14. Which marketing channel has the highest CTR?
SELECT
    marketing_channel,
    ROUND(SUM(clicks) * 100.0 / NULLIF(SUM(impressions), 0), 2) AS ctr_percent
FROM marketing_campaign
GROUP BY marketing_channel
ORDER BY ctr_percent DESC;

--15. Which marketing channel has the highest conversion rate?
SELECT
    marketing_channel,
    ROUND(SUM(conversions) * 100.0 / NULLIF(SUM(clicks), 0), 2) AS conversion_rate_percent
FROM marketing_campaign
GROUP BY marketing_channel
ORDER BY conversion_rate_percent DESC;

--16. Which category has the highest conversion rate?
SELECT
    category,
    ROUND(SUM(conversions) * 100.0 / NULLIF(SUM(clicks), 0), 2) AS conversion_rate_percent
FROM marketing_campaign
GROUP BY category
ORDER BY conversion_rate_percent DESC;

--17. Which campaigns have high impressions but low CTR?
SELECT
    campaign_id,
    product_name,
    marketing_channel,
    impressions,
    clicks,
    ROUND(clicks * 100.0 / NULLIF(impressions, 0), 2) AS ctr_percent
FROM marketing_campaign
WHERE impressions > 300000
  AND (clicks * 100.0 / NULLIF(impressions, 0)) < 3
ORDER BY ctr_percent ASC;

--18. Which campaigns have high clicks but low conversion rates?
SELECT
    campaign_id,
    product_name,
    marketing_channel,
    clicks,
    conversions,
    ROUND(conversions * 100.0 / NULLIF(clicks, 0), 2) AS conversion_rate_percent
FROM marketing_campaign
WHERE clicks > 10000
  AND (conversions * 100.0 / NULLIF(clicks, 0)) < 5
ORDER BY conversion_rate_percent ASC;

--19. Which campaigns achieved the highest ROI?
SELECT
    campaign_id,
    product_name,
    marketing_channel,
    CHR(8377) || ' ' || TO_CHAR(ad_spend_inr, 'FM99,99,99,990.00') AS ad_spend,
    CHR(8377) || ' ' || TO_CHAR(revenue_inr, 'FM99,99,99,990.00') AS revenue,
    roi
FROM marketing_campaign
ORDER BY roi DESC
LIMIT 10;

--20. Which campaigns have the highest advertising spend?
SELECT
    campaign_id,
    product_name,
    marketing_channel,
    CHR(8377) || ' ' || TO_CHAR(ad_spend_inr, 'FM99,99,99,990.00') AS ad_spend,
    roi
FROM marketing_campaign
ORDER BY ad_spend_inr DESC
LIMIT 10;

--21. Which campaigns generate high revenue with low ad spend?
SELECT
    campaign_id,
    product_name,
    marketing_channel,
    CHR(8377) || ' ' || TO_CHAR(ad_spend_inr, 'FM99,99,99,990.00') AS ad_spend,
    CHR(8377) || ' ' || TO_CHAR(revenue_inr, 'FM99,99,99,990.00') AS revenue,
    roi
FROM marketing_campaign
WHERE revenue_inr > 500000
  AND ad_spend_inr < 2000
ORDER BY roi DESC;

--22. Which products have the lowest ROI?
SELECT
    product_name,
    CHR(8377) || ' ' || TO_CHAR(SUM(ad_spend_inr), 'FM99,99,99,990.00') AS ad_spend,
    CHR(8377) || ' ' || TO_CHAR(SUM(revenue_inr), 'FM99,99,99,990.00') AS revenue,
    ROUND(((SUM(revenue_inr) - SUM(ad_spend_inr))
        / NULLIF(SUM(ad_spend_inr), 0)) * 100, 2) AS roi_percent
FROM marketing_campaign
GROUP BY product_name
ORDER BY roi_percent ASC
LIMIT 10;

--23. Which channel-category combinations perform best?
SELECT
    marketing_channel,
    category,
    CHR(8377) || ' ' || TO_CHAR(SUM(revenue_inr), 'FM99,99,99,990.00') AS revenue,
    ROUND(((SUM(revenue_inr) - SUM(ad_spend_inr))
        / NULLIF(SUM(ad_spend_inr), 0)) * 100, 2) AS roi_percent
FROM marketing_campaign
GROUP BY marketing_channel, category
ORDER BY SUM(revenue_inr) DESC;

--24. Which product-channel combinations generate the most revenue?
SELECT
    product_name,
    marketing_channel,
    CHR(8377) || ' ' || TO_CHAR(SUM(revenue_inr), 'FM99,99,99,990.00') AS revenue,
    ROUND(((SUM(revenue_inr) - SUM(ad_spend_inr))
        / NULLIF(SUM(ad_spend_inr), 0)) * 100, 2) AS roi_percent
FROM marketing_campaign
GROUP BY product_name, marketing_channel
ORDER BY SUM(revenue_inr) DESC
LIMIT 20;

--25. What is the average campaign performance by channel?
SELECT
    marketing_channel,
    ROUND(AVG(ad_spend_inr), 2) AS avg_ad_spend,
    ROUND(AVG(revenue_inr), 2) AS avg_revenue,
    ROUND(AVG(conversions), 2) AS avg_conversions,
    ROUND(AVG(roi), 2) AS avg_roi
FROM marketing_campaign
GROUP BY marketing_channel
ORDER BY avg_revenue DESC;

--26. Which day of the week generates the most revenue?
SELECT
    TRIM(TO_CHAR(campaign_date, 'Day')) AS day_of_week,
    CHR(8377) || ' ' || TO_CHAR(SUM(revenue_inr), 'FM99,99,99,990.00') AS revenue
FROM marketing_campaign
GROUP BY TRIM(TO_CHAR(campaign_date, 'Day'))
ORDER BY SUM(revenue_inr) DESC;

--27. Which date generated the highest revenue?
SELECT
    campaign_date,
    COUNT(*) AS campaigns,
    CHR(8377) || ' ' || TO_CHAR(SUM(revenue_inr), 'FM99,99,99,990.00') AS revenue
FROM marketing_campaign
GROUP BY campaign_date
ORDER BY SUM(revenue_inr) DESC
LIMIT 10;

--28. Which campaigns have high spend but poor ROI?
SELECT
    campaign_id,
    product_name,
    marketing_channel,
    CHR(8377) || ' ' || TO_CHAR(ad_spend_inr, 'FM99,99,99,990.00') AS ad_spend,
    CHR(8377) || ' ' || TO_CHAR(revenue_inr, 'FM99,99,99,990.00') AS revenue,
    roi
FROM marketing_campaign
WHERE ad_spend_inr > 4000
  AND roi < 50
ORDER BY ad_spend_inr DESC;

--29. How many campaigns are profitable vs. unprofitable?
SELECT
    CASE
        WHEN revenue_inr > ad_spend_inr THEN 'Profitable'
        ELSE 'Unprofitable'
    END AS campaign_status,
    COUNT(*) AS campaign_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage_of_campaigns
FROM marketing_campaign
GROUP BY campaign_status
ORDER BY campaign_count DESC;

--30. What is the complete monthly marketing performance dashboard query?
SELECT
    DATE_TRUNC('month', campaign_date)::DATE AS month,
    COUNT(*) AS campaigns,
    CHR(8377) || ' ' || TO_CHAR(SUM(ad_spend_inr), 'FM99,99,99,990.00') AS ad_spend,
    CHR(8377) || ' ' || TO_CHAR(SUM(revenue_inr), 'FM99,99,99,990.00') AS revenue,
    CHR(8377) || ' ' || TO_CHAR(
        SUM(revenue_inr) - SUM(ad_spend_inr),
        'FM99,99,99,990.00'
    ) AS profit,
    ROUND(((SUM(revenue_inr) - SUM(ad_spend_inr))
        / NULLIF(SUM(ad_spend_inr), 0)) * 100, 2) AS roi_percent,
    SUM(impressions) AS impressions,
    SUM(clicks) AS clicks,
    SUM(conversions) AS conversions,
    ROUND(SUM(clicks) * 100.0 / NULLIF(SUM(impressions), 0), 2) AS ctr_percent,
    ROUND(SUM(conversions) * 100.0 / NULLIF(SUM(clicks), 0), 2) AS conversion_rate_percent
FROM marketing_campaign
GROUP BY 1
ORDER BY 1;

