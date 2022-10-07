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
		
--3. ROW_NUMBER()
SELECT 
A.Name as "ProductName",
A.ListPrice,
B.Name as "ProductSubcategory",
C.Name as "ProductCategory",
PriceRank = ROW_NUMBER() OVER (ORDER BY ListPrice DESC),
CategoryPriceRank = ROW_NUMBER() OVER( PARTITION BY C.Name ORDER BY ListPrice DESC),
CASE WHEN ( ROW_NUMBER() OVER(PARTITION BY C.Name ORDER BY ListPrice DESC) BETWEEN 1 AND 5) THEN 'YES'
		ELSE 'NO' END AS "Top 5 Price In Category"

FROM AdventureWorks2019.Production.Product A
		INNER JOIN AdventureWorks2019.Production.ProductSubcategory B
				ON A.ProductSubcategoryID = B.ProductSubcategoryID
		INNER JOIN AdventureWorks2019.Production.ProductCategory C
				ON B.ProductCategoryID = C.ProductCategoryID

