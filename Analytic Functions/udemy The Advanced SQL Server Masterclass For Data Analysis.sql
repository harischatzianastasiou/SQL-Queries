--1. 
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
