SELECT 
    p.FirstName, 
    p.LastName, 
    e.JobTitle
FROM HumanResources.Employee AS e
INNER JOIN Person.Person AS p 
    ON e.BusinessEntityID = p.BusinessEntityID;

SELECT 
    c.CustomerID, 
    p.FirstName, 
    p.LastName
FROM Sales.Customer AS c
LEFT JOIN Person.Person AS p 
    ON c.PersonID = p.BusinessEntityID;

SELECT 
    soh.SalesOrderID, 
    c.CustomerID
FROM Sales.SalesOrderHeader AS soh
RIGHT JOIN Sales.Customer AS c 
    ON soh.CustomerID = c.CustomerID;

SELECT 
    p.Name, 
    pr.Comments
FROM Production.Product AS p
FULL OUTER JOIN Production.ProductReview AS pr 
    ON p.ProductID = pr.ProductID;

SELECT 
    p.Name AS ProductName, 
    pc.Name AS CategoryName
FROM Production.Product AS p
CROSS JOIN Production.ProductCategory AS pc;

SELECT Name 
FROM Production.Product
UNION
SELECT Name 
FROM Production.ProductModel;

SELECT Name 
FROM Production.Product
UNION ALL
SELECT Name 
FROM Production.ProductModel;

SELECT 
    BusinessEntityID,
    COALESCE(JobTitle, 'No Title') AS JobTitle,
    CASE 
        WHEN JobTitle LIKE '%Manager%' THEN 'Manager'
        ELSE 'Not Manager'
    END AS JobCategory
FROM HumanResources.Employee;

SELECT 
    BusinessEntityID,
    SalesQuota,
    ISNULL(CAST(SalesQuota AS VARCHAR(20)), 'No quota') AS QuotaStatus
FROM Sales.SalesPerson;