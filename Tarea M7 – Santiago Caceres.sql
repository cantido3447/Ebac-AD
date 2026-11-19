USE AdventureWorks2022;

-- 1. Selecciona todos los datos de la tabla Person.Person
SELECT * 
FROM Person.Person;

-- 2. Seleccionar todos los empleados cuya columna JobTitle sea 'Marketing Specialist'
SELECT * 
FROM HumanResources.Employee
WHERE JobTitle = 'Marketing Specialist';

-- 3. Ordena los empleados de la tabla HumanResources.Employee por HireDate en orden descendente
SELECT * 
FROM HumanResources.Employee
ORDER BY HireDate DESC;

-- 4. Seleccione los productos cuyo precio esté entre 20 y 100 (tabla Production.Product)
SELECT * 
FROM Production.Product
WHERE ListPrice BETWEEN 20 AND 100;