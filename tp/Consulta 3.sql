USE DataWarehouse_Sales;
GO

SELECT 
    c.CATEGORY AS Nombre_Categoria,
    p.BRAND AS Marca,
    COUNT(DISTINCT f.ITEM_CODE) AS Total_Productos_Vendidos,
    ROUND(SUM(f.TOTAL_UNIT_SALES), 2) AS Unidades_Totales,
    ROUND(SUM(f.TOTAL_VALUE_SALES), 2) AS Ventas_Valor_Total
FROM FACT_SALES f
LEFT JOIN DIM_PRODUCT p 
    ON f.ITEM_CODE = p.ITEM
LEFT JOIN DIM_CATEGORY c 
    ON p.CATEGORY = c.ID_CATEGORY
GROUP BY c.CATEGORY, p.BRAND
ORDER BY Ventas_Valor_Total DESC;

-- 2. Evolución de ventas semanales (Tendencia)
SELECT 
    cal.WEEK AS Semana,
    cal.YEAR AS Anio,
    ROUND(SUM(f.TOTAL_VALUE_SALES), 2) AS Ventas_Semanales
FROM FACT_SALES f
LEFT JOIN DIM_CALENDAR cal 
    ON f.WEEK = cal.WEEK
GROUP BY cal.WEEK, cal.YEAR
ORDER BY cal.YEAR, cal.WEEK;