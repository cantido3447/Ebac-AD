SELECT 
    ProductID,
    SUM(OrderQty) AS TotalQuantity,
    SUM(LineTotal) AS TotalSales
FROM Sales.SalesOrderDetail
GROUP BY ProductID;

SELECT 
    ProductID,
    SUM(OrderQty) AS TotalQuantity
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(OrderQty) > 50;

SELECT 
    SalesOrderID,
    ProductID,
    LineTotal,
    SUM(LineTotal) OVER(PARTITION BY SalesOrderID) AS TotalOrderValue
FROM Sales.SalesOrderDetail;

SELECT 
    SalesOrderID,
    SalesOrderDetailID,
    ProductID,
    LineTotal,
    ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY SalesOrderDetailID) AS RowNum
FROM Sales.SalesOrderDetail;

SELECT 
    SalesOrderID,
    ProductID,
    LineTotal,
    RANK() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC) AS [Rank]
FROM Sales.SalesOrderDetail;

SELECT 
    SalesOrderID,
    ProductID,
    LineTotal,
    DENSE_RANK() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC) AS DenseRank
FROM Sales.SalesOrderDetail;

SELECT 
    ProductID,
    SUM(LineTotal) AS TotalSales
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(LineTotal) > 5000
ORDER BY TotalSales DESC;