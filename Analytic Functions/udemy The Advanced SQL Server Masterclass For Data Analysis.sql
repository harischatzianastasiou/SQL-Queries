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

--5. Subqueries 
--Write a query that displays the three most expensive orders, per vendor ID, from the Purchasing.PurchaseOrderHeader table.
--Ultimately, you should see three distinct total due amounts (i.e., the top three) for each group of like Vendor Ids. However, there could be multiple records for each of these amounts.
--"Most expensive" is defined by the amount in the "TotalDue" field.

SELECT 
*
FROM
(
SELECT 
	A.PurchaseOrderID,
	A.VendorID,
	A.OrderDate,
	A.TaxAmt,
	A.Freight,
	A.TotalDue,
	[Rank] = ROW_NUMBER() OVER(PARTITION BY A.VendorID ORDER BY A.TotalDue DESC),
	DenseRank = DENSE_RANK() OVER(PARTITION BY A.VendorID ORDER BY A.TotalDue DESC)
FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader A
) B

WHERE DenseRank <= 3; 

-- Scalar Subqueries

SELECT 

A.BusinessEntityID,
A.JobTitle,
A.VacationHours,
MaxVacationHours =
	( 
	SELECT
	max(B.VacationHours) 
	FROM AdventureWorks2019.HumanResources.Employee B
	),
VacationHoursPercent =
		(A.VacationHours *1.0)/ (
					SELECT 
					max(B.VacationHours) 
					FROM AdventureWorks2019.HumanResources.Employee B
					)  *100	
FROM AdventureWorks2019.HumanResources.Employee A
WHERE 
(A.VacationHours *1.0)/(
			SELECT 
			max(B.VacationHours) 
			FROM AdventureWorks2019.HumanResources.Employee B
			)  *100
>=80

--Correlated Subqueries

SELECT

A.PurchaseOrderID
,A.VendorID
,A.OrderDate
,A.TotalDue
,NonRejectedItems = 
(
	SELECT
	count(*)
	FROM AdventureWorks2019.Purchasing.PurchaseOrderDetail B
	WHERE A.PurchaseOrderID = B.PurchaseOrderID
	AND B.RejectedQty =0 
)
,MostExpensiveItem = 
(
	SELECT
	max(B.UnitPrice)
	FROM AdventureWorks2019.Purchasing.PurchaseOrderDetail B
	WHERE A.PurchaseOrderID = B.PurchaseOrderID
)
FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader A;

--EXISTS() , NOT EXISTS()

SELECT 
*
FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader A

WHERE EXISTS
(
	SELECT
	1
	FROM AdventureWorks2019.Purchasing.PurchaseOrderDetail B
	WHERE A.PurchaseOrderID = B.PurchaseOrderID
	AND B.OrderQty > 500
	AND B.UnitPrice > 50
)

ORDER BY PurchaseOrderID;

SELECT 
*
FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader A

WHERE NOT EXISTS
(
	SELECT
	1
	FROM AdventureWorks2019.Purchasing.PurchaseOrderDetail B
	WHERE A.PurchaseOrderID = B.PurchaseOrderID
	AND B.RejectedQty > 0
)

ORDER BY PurchaseOrderID;

