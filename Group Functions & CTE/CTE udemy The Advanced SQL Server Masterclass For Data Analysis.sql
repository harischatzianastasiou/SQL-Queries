WITH Sales AS
(
SELECT 
       OrderDate
	  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
      ,TotalDue
	  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2019.Sales.SalesOrderHeader
)

,SalesMinusTop10 AS
(
SELECT
OrderMonth,
TotalSales = SUM(TotalDue)
FROM Sales
WHERE OrderRank > 10
GROUP BY OrderMonth
)

,Purchases AS
(
SELECT 
       OrderDate
	  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
      ,TotalDue
	  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader
)

,PurchasesMinusTop10 AS
(
SELECT
OrderMonth,
TotalPurchases = SUM(TotalDue)
FROM Purchases
WHERE OrderRank > 10
GROUP BY OrderMonth
)


SELECT
A.OrderMonth,
A.TotalSales,
B.TotalPurchases

FROM SalesMinusTop10 A
	JOIN PurchasesMinusTop10 B
		ON A.OrderMonth = B.OrderMonth

ORDER BY 1

--Recursive CTEs
--Exercise 1 Solution:


WITH Odds AS
(
SELECT
 1 AS MyOddNumber

UNION  ALL

SELECT 
MyOddNumber + 2
FROM Odds
WHERE MyOddNumber < 99
)

SELECT
MyOddNumber
FROM Odds




--Exercise 2 Solution:


WITH Dates AS
(
SELECT
 CAST('01-01-2020' AS DATE) AS MyDate

UNION ALL

SELECT
DATEADD(MONTH, 1, MyDate)
FROM Dates
WHERE MyDate < CAST('12-01-2029' AS DATE)
)

SELECT
MyDate

FROM Dates
OPTION (MAXRECURSION 120)
