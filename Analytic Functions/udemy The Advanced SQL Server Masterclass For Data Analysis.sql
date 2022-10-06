--1. OVER(...)
SELECT 
 B.FirstName,
 B.LastName,
 C.JobTitle,
 A.Rate,
 AVG(A.Rate) OVER() AverageRate,
 MAX(A.Rate) OVER() MaximumRate,
 A.Rate - AVG(A.Rate) OVER() DiffFromAverageRate,
 A.Rate / MAX(A.Rate) OVER() * 100 PercentofMaxRate

FROM AdventureWorks2019.HumanResources.EmployeePayHistory A
	JOIN AdventureWorks2019.Person.Person B
		ON A.BusinessEntityID = B.BusinessEntityID
	JOIN AdventureWorks2019.HumanResources.Employee C
		ON A.BusinessEntityID = C.BusinessEntityID

--2. OVER(PARTITION BY ...)
SELECT 
A.Name ProductName,
A.ListPrice,
B.Name ProductSubcategory,
C.Name ProductCategory,
avg(A.ListPrice) OVER(PARTITION BY C.Name) AvgPriceByCategory,
avg(A.ListPrice) OVER(PARTITION BY C.Name,B.NAME) AvgPriceByCategoryAndSubcategory,
A.ListPrice - avg(A.ListPrice) OVER(PARTITION BY C.Name) ProductVsCategoryDelta

FROM AdventureWorks2019.Production.Product A
	INNER JOIN AdventureWorks2019.Production.ProductSubcategory B 
		ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN AdventureWorks2019.Production.ProductCategory C 
		ON C.ProductCategoryID = B.ProductCategoryID;
