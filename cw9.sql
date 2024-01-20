-- ZAD 1

WITH cte_EmployeeInfo AS
(
SELECT h.BusinessEntityID, FirstName, LastName, Gender, BirthDate, MaritalStatus, HireDate, Rate FROM Person.Person p
JOIN HumanResources.EmployeePayHistory h
ON p.BusinessEntityID = h.BusinessEntityID
JOIN HumanResources.Employee e
ON e.BusinessEntityID = p.BusinessEntityID
)
SELECT DISTINCT * INTO #temp_table FROM cte_EmployeeInfo

SELECT * FROM #temp_table


-- ZAD 2

WITH cte_revenue AS 
(
SELECT CONCAT(CompanyName,' (',FirstName,' ', LastName, ')') AS CompanyContact, TotalDue
FROM SalesLT.SalesOrderDetail d
JOIN SalesLT.SalesOrderHeader h ON d.SalesOrderID = h.SalesOrderID
JOIN SalesLT.Customer c ON c.CustomerID = h.CustomerID
)
SELECT CompanyContact, TotalDue AS Revenue FROM cte_revenue
GROUP BY CompanyContact, TotalDue
ORDER BY CompanyContact


-- ZAD 3

WITH cte_sel AS
(
SELECT pc.Name, LineTotal FROM SalesLT.ProductCategory pc
JOIN SalesLT.Product p ON p.ProductCategoryID = pc.ProductCategoryID
JOIN SalesLT.SalesOrderDetail s ON p.ProductID = s.ProductID
JOIN SalesLT.SalesOrderHeader h ON s.SalesOrderID = h.SalesOrderID
)
SELECT Name, SUM(LineTotal) AS SalesValue FROM cte_sel
GROUP BY Name
ORDER BY Name