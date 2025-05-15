CREATE TABLE campaigndata 
  (
	Campaign_ID	int,
	Company	varchar(25),
	Campaign_Type varchar(25),	
	Target_Audience	varchar(25),
	Duration varchar(25),
	Channel_Used varchar(25),
	Conversion_Rate	float,
	Acquisition_Cost money,
	ROI float,
	Location varchar(25),
	Date date,
	Clicks int,
	Impressions int,	
	Engagement_Score int,	
	Customer_Segment varchar(40)
);
  
-- 1. Calculate Total Impressions for Each Campaign
SELECT campaign_id, impressions AS totalimpressions
FROM campaigndata

-- 2. Identify the Campaign with the Highest ROI
SELECT campaign_id, company, roi
FROM campaigndata
ORDER BY roi DESC
LIMIT 1;

-- 3. Find the Top 3 Locations with the Most Impressions
SELECT location, SUM(impressions) AS totalimpressions
FROM campaigndata
GROUP BY location
ORDER BY totalimpressions DESC
LIMIT 3;

-- 4. Calculate Average Engagement Score by Target Audience
SELECT target_audience, AVG(engagement_score) AS avgengagementscore
FROM campaigndata
GROUP BY target_audience
ORDER BY avgengagementscore DESC;

-- 5. Calculate the Overall CTR (Click-Through Rate)
SELECT (SUM(clicks) * 100.0 / NULLIF(SUM(impressions), 0)) AS overallctr
FROM campaigndata;

-- 6. Find the Most Cost-Effective Campaign
SELECT campaign_id, company, 
       (acquisition_cost::NUMERIC / NULLIF(conversion_rate, 0)) AS costperconversion
FROM campaigndata
ORDER BY costperconversion ASC
LIMIT 1;

-- 7. Find Campaigns with CTR Above a Threshold
SELECT campaign_id, company, (clicks * 100.0 / impressions) AS ctr
FROM campaigndata
WHERE (clicks * 100.0 / impressions) > 5;

-- 8. Rank Channels by Total Conversions
SELECT channel_used, SUM(conversion_rate * impressions) AS totalconversions
FROM campaigndata
GROUP BY channel_used
ORDER BY totalconversions DESC;

