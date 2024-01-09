-- ZAD 1

CREATE FUNCTION CreateFibonacciSeries(@n INT)
RETURNS @FibTable TABLE ( Wyraz INT )
BEGIN
	
	INSERT INTO @FibTable VALUES (1),(1);

	IF @n <= 2 RETURN;

	DECLARE @a INT;
	DECLARE @b INT;

	SET @a = 1;
	SET @b = 1;
	DECLARE @f INT;
	
	DECLARE @i INT;
	SET @i = 3;

	WHILE @i <= @n
	BEGIN
		SET @f = @a + @b;
		INSERT INTO @FibTable VALUES (@f);

		SET @a = @b;
		SET @b = @f;
		SET @i = @i + 1;
	END
	
	RETURN;
END

CREATE PROCEDURE FibSer @n INT
AS
SELECT * FROM [dbo].[CreateFibonacciSeries](@n);
GO


EXEC FibSer @n = 8;

-- ZAD 2
CREATE TRIGGER UpperCase ON Person.Person
AFTER INSERT
AS
BEGIN
	UPDATE Person.Person
	SET LastName = UPPER(LastName)
	WHERE BusinessEntityID = (SELECT TOP 1 BusinessEntityID FROM INSERTED ORDER BY BusinessEntityID DESC); --dziala tylko na nowo dodanych
END

INSERT INTO Person.Person(BusinessEntityID,PersonType,FirstName,LastName) VALUES
(20780,'IN','Andrzej','Kmiciciciñski')

-- ZAD 3

CREATE TRIGGER taxRateMonitoring ON Sales.SalesTaxRate
INSTEAD OF UPDATE
AS
BEGIN
	DECLARE @i SMALLMONEY; -- i - wartosc przed
	SET @i = (SELECT TOP 1 TaxRate FROM deleted);

	DECLARE @n SMALLMONEY; -- n - wartosc po 
	SET @n = (SELECT TOP 1 TaxRate FROM inserted );

	IF (ABS(@i - @n))/(@i) > 0.3
	BEGIN
		RAISERROR('Blad! Zmiana wartosci TaxRate o wiecej niz 30 procent',9,5)
	END
END

UPDATE Sales.SalesTaxRate
SET TaxRate = 1.1*TaxRate;

SELECT * FROM Sales.SalesTaxRate