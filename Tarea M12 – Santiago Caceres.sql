USE AdventureWorks2022;
GO
    
-- 1. Vista Production.vCostoProductoSimple
DROP VIEW IF EXISTS Production.vCostoProductoSimple;
GO
CREATE VIEW Production.vCostoProductoSimple AS
SELECT 
    ProductID,
    Name AS NombreProducto,
    ListPrice AS PrecioLista
FROM Production.Product;
GO

-- 2. Vista Production.vProductoConCosto
DROP VIEW IF EXISTS Production.vProductoConCosto;
GO
CREATE VIEW Production.vProductoConCosto AS
SELECT 
    p.ProductID,
    p.Name AS NombreProducto,
    p.ListPrice AS PrecioLista,
    pch.StandardCost AS CostoEstandar,
    pch.StartDate AS FechaInicio
FROM Production.Product p
INNER JOIN Production.ProductCostHistory pch 
    ON p.ProductID = pch.ProductID;
GO

-- 3. Función dbo.fnCalcularDescuento
DROP FUNCTION IF EXISTS dbo.fnCalcularDescuento;
GO
CREATE FUNCTION dbo.fnCalcularDescuento
(
    @Precio DECIMAL(18,2),
    @Descuento DECIMAL(18,2)
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    RETURN @Precio * (1 - @Descuento);
END;
GO

-- 4. Función dbo.fnLimpiarTexto
DROP FUNCTION IF EXISTS dbo.fnLimpiarTexto;
GO
CREATE FUNCTION dbo.fnLimpiarTexto
(
    @Texto NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    SET @Texto = TRIM(@Texto);
    SET @Texto = UPPER(@Texto);
    
    SET @Texto = REPLACE(@Texto, 'Á', 'A');
    SET @Texto = REPLACE(@Texto, 'É', 'E');
    SET @Texto = REPLACE(@Texto, 'Í', 'I');
    SET @Texto = REPLACE(@Texto, 'Ó', 'O');
    SET @Texto = REPLACE(@Texto, 'Ú', 'U');
    SET @Texto = REPLACE(@Texto, 'Ñ', 'N');

    RETURN @Texto;
END;
GO

-- 5. Procedimiento almacenado dbo.uspObtenerProductosCostosos
DROP PROCEDURE IF EXISTS dbo.uspObtenerProductosCostosos;
GO
CREATE PROCEDURE dbo.uspObtenerProductosCostosos
    @PrecioMin DECIMAL(18,2)
AS
BEGIN
    SELECT 
        ProductID,
        Name AS NombreProducto,
        ListPrice AS PrecioLista
    FROM Production.Product
    WHERE ListPrice > @PrecioMin;
END;
GO

-- 6. Pruebas y ejecuciones
SELECT dbo.fnCalcularDescuento(100, 0.1) AS PrecioConDescuento;
SELECT dbo.fnLimpiarTexto('   áéíóúñ   ') AS TextoLimpio;
EXEC dbo.uspObtenerProductosCostosos @PrecioMin = 1000;
GO