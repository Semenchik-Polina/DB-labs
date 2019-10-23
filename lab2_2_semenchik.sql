-- Task 2.2, variant 3

-- Task 2.2 1 
CREATE TABLE dbo.Address(
	AddressID INT NOT NULL,
	AddressLine1 NVARCHAR(60) NOT NULL,
	AddressLine2 NVARCHAR(60) NOT NULL,
	City NVARCHAR(30) NOT NULL,
	StateProvinceId INT NOT NULL,
	PostalCode NVARCHAR(15) NOT NULL,
	ModifiedDate DATETIME NOT NULL
); 


-- Task 2.2 2
ALTER TABLE dbo.Address
ADD CONSTRAINT PK_Address 
PRIMARY KEY(StateProvinceId, PostalCode);


-- Task 2.2 3
ALTER TABLE dbo.Address
ADD CHECK (PostalCode NOT LIKE '%[A-Za-z]%');


-- Task 2.2 4
ALTER TABLE dbo.Address
ADD DEFAULT GETDATE() FOR ModifiedDate;


-- Task 2.2 5
INSERT INTO dbo.Address( AddressID, AddressLine1, AddressLine2, City, StateProvinceId, PostalCode, ModifiedDate )
SELECT tempTable.AddressID,	tempTable.AddressLine1, tempTable.AddressLine2, tempTable.City, tempTable.StateProvinceID, tempTable.PostalCode, tempTable.ModifiedDate
FROM(
	
	-- ƒл€ группы данных из полей StateProvinceID и PostalCode выберите только строки с максимальным AddressID
	SELECT DISTINCT a.StateProvinceID,	a.PostalCode,
			MAX(AddressID) 
			OVER(
				PARTITION BY a.StateProvinceID, a.PostalCode
				) AS MaxAddress 
		FROM Person.Address a
	) AS maxAddr
	
	-- јдреса, где CountryRegionCode = СUSТ , PostalCode  не содержит буквы
	INNER JOIN (
		SELECT a.AddressID, a.AddressLine1, a.AddressLine2, a.City, a.StateProvinceID, a.PostalCode, a.ModifiedDate 
		FROM Person.Address a
		INNER JOIN Person.StateProvince sp
		ON a.StateProvinceID = sp.StateProvinceID
		WHERE sp.CountryRegionCode='US' AND a.PostalCode NOT LIKE '%[A-Za-z]%'
	) AS tempTable

	ON maxAddr.PostalCode = tempTable.PostalCode AND maxAddr.StateProvinceID = tempTable.StateProvinceID AND maxAddr.MaxAddress = tempTable.AddressID;


-- Task 2.2 6
ALTER TABLE dbo.Address 
ALTER COLUMN City NVARCHAR(20)