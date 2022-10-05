SELECT SUM(TotalDue) 
FROM AdventureWorks2019.Sales.SalesOrderHeader

SELECT TotalSales = SUM(TotalDue), SalesPersonID 
FROM AdventureWorks2019.Sales.SalesOrderHeader
GROUP BY SalesPersonID;
