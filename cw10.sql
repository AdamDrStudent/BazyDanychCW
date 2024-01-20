-- ZAD 1
BEGIN TRANSACTION

UPDATE Production.Product
SET ListPrice = 1.1 * ListPrice
WHERE ProductID = 680;

SELECT * FROM Production.Product
WHERE ProductID = 680

COMMIT;


-- ZAD 2
BEGIN TRANSACTION

SET IDENTITY_INSERT Production.Product ON;

INSERT INTO Production.Product(ProductID,Name,ProductNumber,SafetyStockLevel,ReorderPoint,StandardCost,ListPrice,DaysToManufacture,SellStartDate) VALUES
(1000,'Ziomal1000','XD2003',75,100,444.444,442.323,8,'2023-12-31 00:00:00.000')

COMMIT;

-- ZAD 3
BEGIN TRANSACTION

DELETE FROM Production.Product
WHERE ProductID = 1000;

COMMIT;

-- ZAD 4
BEGIN TRANSACTION

DECLARE @sum MONEY;
SET @sum = (SELECT SUM(StandardCost) FROM Production.Product);

IF @sum < 500000
BEGIN
	UPDATE Production.Product
	SET StandardCost = 1.1 * StandardCost;
	COMMIT;
END

ELSE
ROLLBACK;

-- ZAD 5 
BEGIN TRANSACTION

INSERT INTO Production.Product(ProductID,Name,ProductNumber,SafetyStockLevel,ReorderPoint,StandardCost,ListPrice,DaysToManufacture,SellStartDate) VALUES
(1000,'Ziomal1000','XD2003',75,100,444.444,442.323,8,'2023-12-31 00:00:00.000');

IF (SELECT COUNT(Name) FROM Production.Product WHERE Name = 'Ziomal1000') >  1
ROLLBACK;

ELSE
COMMIT;

-- ZAD 6

BEGIN TRANSACTION

UPDATE Sales.SalesOrderDetail
SET OrderQty = OrderQty + 1;

IF (SELECT COUNT(OrderQty) FROM Sales.SalesOrderDetail WHERE OrderQty = 0) > 0
ROLLBACK;

ELSE
COMMIT;

SELECT OrderQty FROM Sales.SalesOrderDetail

-- ZAD 7
BEGIN TRANSACTION

DECLARE @a MONEY;
SET @a = (SELECT AVG(StandardCost) FROM Production.Product);

DECLARE @n INT;
SET @n = (SELECT COUNT(StandardCost) FROM Production.Product WHERE StandardCost > @a)

IF @n > 200
ROLLBACK;

ELSE
BEGIN
UPDATE Production.Product
SET StandardCost = 0.9 * StandardCost
WHERE StandardCost > @a;
END

COMMIT;