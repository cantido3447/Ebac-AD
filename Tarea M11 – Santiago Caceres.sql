USE AdventureWorks2022;
GO

SELECT Name, ProductID
FROM Production.Product
WHERE ProductID IN (
    SELECT DISTINCT ProductID 
    FROM Sales.SalesOrderDetail
)
ORDER BY Name ASC;

SELECT 
    e.BusinessEntityID,
    p.FirstName + ' ' + p.LastName AS Empleado,
    d.Name AS Departamento
FROM HumanResources.Employee e
INNER JOIN Person.Person p 
    ON e.BusinessEntityID = p.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory edh 
    ON e.BusinessEntityID = edh.BusinessEntityID
INNER JOIN HumanResources.Department d 
    ON edh.DepartmentID = d.DepartmentID
WHERE edh.EndDate IS NULL;

WITH EmpleadosDepartamentos AS (
    SELECT 
        e.BusinessEntityID,
        p.FirstName + ' ' + p.LastName AS Empleado,
        d.Name AS Departamento
    FROM HumanResources.Employee e
    INNER JOIN Person.Person p 
        ON e.BusinessEntityID = p.BusinessEntityID
    INNER JOIN HumanResources.EmployeeDepartmentHistory edh 
        ON e.BusinessEntityID = edh.BusinessEntityID
    INNER JOIN HumanResources.Department d 
        ON edh.DepartmentID = d.DepartmentID
    WHERE edh.EndDate IS NULL
)
SELECT BusinessEntityID, Empleado, Departamento
FROM EmpleadosDepartamentos;

IF OBJECT_ID('tempdb..#ProductosOrdenadosLocal') IS NOT NULL 
    DROP TABLE #ProductosOrdenadosLocal;
IF OBJECT_ID('tempdb..##ProductosOrdenadosGlobal') IS NOT NULL 
    DROP TABLE ##ProductosOrdenadosGlobal;

CREATE TABLE #ProductosOrdenadosLocal (
    ProductID INT,
    Name NVARCHAR(50)
);

INSERT INTO #ProductosOrdenadosLocal (ProductID, Name)
SELECT ProductID, Name
FROM Production.Product;

CREATE TABLE ##ProductosOrdenadosGlobal (
    ProductID INT,
    Name NVARCHAR(50)
);

INSERT INTO ##ProductosOrdenadosGlobal (ProductID, Name)
SELECT ProductID, Name
FROM Production.Product;

SELECT ProductID, Name 
FROM #ProductosOrdenadosLocal;

SELECT SalesOrderNumber, PurchaseOrderNumber
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011;

SELECT 
    SUBSTRING(SalesOrderNumber, 3, LEN(SalesOrderNumber)) AS NewSalesOrderNumber,
    SUBSTRING(PurchaseOrderNumber, 3, LEN(PurchaseOrderNumber)) AS NewPurchaseOrderNumber
FROM Sales.SalesOrderHeader;