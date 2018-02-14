--DROP TABLE #EDVisits
SELECT StartDate
	, StartdateFiscalPeriodLong
	, StartDateFiscalYear
	--, StarttoDispositionExclCDU
	--, AdmittedFlag
	--, TriageAcuityCode
	, count(*) as [num visits]
INTO #EDVisits
FROM [EDMart].[dbo].[vwEDVisitIdentifiedRegional]
WHERE StartDateFiscalYear in ('10/11', '11/12', '12/13', '13/14', '14/15', '15/16', '16/17','17/18') 
	and StartDate < '04/01/2017' and FacilityShortName = 'VGH'
group by StartDate
	, StartdateFiscalPeriodLong
	, StartDateFiscalYear

SELECT * FROM #EDVisits
ORDER BY StartDate; 

