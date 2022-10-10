--1. Subqueries 

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

-- FOR XML PATH WITH STUFF

SELECT 
       SubcategoryName = A.[Name]
	  ,Products =
		STUFF(
			(
				SELECT
					';' + B.Name

				FROM AdventureWorks2019.Production.Product B

				WHERE A.ProductSubcategoryID = B.ProductSubcategoryID

				FOR XML PATH('')

			),1,1,''
		)

  FROM AdventureWorks2019.Production.ProductSubcategory A
  
  --PIVOT
  SELECT
*
FROM
(
SELECT 
JobTitle,
VacationHours

FROM AdventureWorks2019.HumanResources.Employee
) A

PIVOT(
AVG(VacationHours)
FOR JobTitle IN([Sales Representative],[Buyer],[Janitor])
) B
