-- Jonathan Feng
-- StatisticsFeed Assignment

--QUERY 1
GO

USE [Statistics Feed];
DROP PROCEDURE IF EXISTS DataMetrics;
GO
CREATE PROCEDURE DataMetric
(
	@DateMetrics DATE
)
AS
BEGIN
SET NOCOUNT ON;
	-- COUNT OF REVIEWS
	SELECT
		COUNT(sr.publication_id) as ReviewCount
	FROM
		dbo.standardizedreviews as sr
	WHERE
		@DateMetrics = CAST(sr.date as DATE);

	-- P5
	SELECT DISTINCT
		PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY sr.adjusted_score) OVER () AS fiveP
	FROM
		dbo.standardizedreviews as sr;

	-- P95
	SELECT DISTINCT
		PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY sr.adjusted_score) OVER () AS ninteyfiveP
	FROM
		dbo.standardizedreviews as sr;

	--Name, Title, URL
	SELECT 
		p.name as Name,
		m.name as Title,
		p.url as URL,
		sr.adjusted_score
	FROM
		dbo.standardizedreviews as sr
	INNER JOIN
		dbo.media as m ON m.media_id = sr.media_id
	INNER JOIN
		dbo.publications as p ON p.publication_id = sr.publication_id
	WHERE 
		@DateMetrics = CAST(sr.date as DATE) AND sr.adjusted_score IN (
		SELECT MAX(sr.adjusted_score) FROM dbo.standardizedreviews as sr WHERE @DateMetrics = CAST(sr.date as DATE)
		);
END
GO

EXEC DataMetric @DateMetrics='2020-01-07'
GO
-- QUERY 2 News Feed

CREATE PROCEDURE NewsFeed (@PreviousDate DATE)
AS
BEGIN

-- Selecting All Name, Title, and Links for shows after selected date
SET NOCOUNT ON;
	SELECT 
		p.name as Name,
		m.name as Title,
		p.url as URL
	FROM
		dbo.standardizedreviews as sr
	INNER JOIN
		dbo.media as m ON m.media_id = sr.media_id
	INNER JOIN
		dbo.publications as p ON p.publication_id = sr.publication_id
	WHERE
		CAST(sr.date as DATE) > @PreviousDate
	ORDER BY
		sr.date
	ASC;

	-- Average for all Shows + Movies
	SELECT
		AVG(sr.adjusted_score) as AvgScoreAllMovies
	FROM
		dbo.standardizedreviews as sr;

	--End Date or Most recent Date of reviews
	SELECT
		CAST(MAX(sr.date) AS DATE) EndDate
	FROM
		dbo.standardizedreviews as sr;
END
GO


EXEC NewsFeed @PreviousDate='2012-09-21'
GO
-- QUERY 3 TOP 10 Best Rated Tv Shows
-- I used the AVERAGE function to determine the TV show's adjusted scores and used the GROUP BY
-- clause to consolidate all show reviews together

CREATE PROCEDURE BEST_WORST_FEED
AS
BEGIN

SELECT TOP 10
	m.name as Name,
	AVG(sr.adjusted_score) as Average_Adjusted_score
FROM
	dbo.standardizedreviews as sr
INNER JOIN
	dbo.media as m ON m.media_id = sr.media_id
WHERE
	m.media_type_id = 2
GROUP BY
	Name
ORDER BY
	Average_Adjusted_score DESC;


--QUERY 3 top 10 worst tv shows by ascending rank

SELECT TOP 10
	m.name as Name,
	AVG(sr.adjusted_score) as Average_Adjusted_score
FROM
	dbo.standardizedreviews as sr
INNER JOIN
	dbo.media as m ON m.media_id = sr.media_id
WHERE
	m.media_type_id = 2
GROUP BY
	Name
ORDER BY
	Average_Adjusted_score ASC;

END
GO

EXEC BEST_WORST_FEED
GO