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
		
--3. ROW_NUMBER(),RANK(),DENSE_RANK()

SELECT 
  ProductName = A.Name,
  A.ListPrice,
  ProductSubcategory = B.Name,
  ProductCategory = C.Name,
  [Price Rank] = ROW_NUMBER() OVER(ORDER BY A.ListPrice DESC),
  [Category Price Rank] = ROW_NUMBER() OVER(PARTITION BY C.Name ORDER BY A.ListPrice DESC),
  [Category Price Rank With Rank] = RANK() OVER(PARTITION BY C.Name ORDER BY A.ListPrice DESC),
  [Category Price Rank With Dense Rank] = DENSE_RANK() OVER(PARTITION BY C.Name ORDER BY A.ListPrice DESC),
  [Top 5 Price In Category] = 
	CASE 
		WHEN DENSE_RANK() OVER(PARTITION BY C.Name ORDER BY A.ListPrice DESC) <= 5 THEN 'Yes'
		ELSE 'No'
	END


  FROM AdventureWorks2019.Production.Product A
  JOIN AdventureWorks2019.Production.ProductSubcategory B
  ON A.ProductSubcategoryID = B.ProductSubcategoryID
  JOIN AdventureWorks2019.Production.ProductCategory C
  ON B.ProductCategoryID = C.ProductCategoryID
  
  --4. LAG() and LEAD()

SELECT 
	A.PurchaseOrderID,
	A.OrderDate,
	B.Name as "VendorName",
	A.TotalDue,
	PrevOrderFromVendorAmt = LAG(A.TotalDue,1) OVER(PARTITION BY A.VendorID ORDER BY A.OrderDate),
	NextOrderByEmployeeVendor = LEAD(B.Name,1) OVER(PARTITION BY A.EmployeeID ORDER BY A.OrderDate),
	Next2OrderByEmployeeVendor = LEAD(B.Name,2) OVER(PARTITION BY A.EmployeeID ORDER BY A.OrderDate)

FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader A
	INNER JOIN Purchasing.Vendor B 
		ON A.VendorID = B.BusinessEntityID

WHERE A.OrderDate >= '01-JAN-2013'
AND A.TotalDue > 500;


  
