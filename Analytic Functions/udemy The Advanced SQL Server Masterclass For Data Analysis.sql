SELECT SUM(TotalDue) 
FROM AdventureWorks2019.Sales.SalesOrderHeader

SELECT TotalSales = SUM(TotalDue),PersonSalesID 
FROM AdventureWorks2019.Sales.SalesOrderHeader
GROUP BY PersonSalesID;

 
