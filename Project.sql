CREATE DATABASE [DHarbour]
USE [DHarbour]

CREATE TABLE [Customer](
	[ID] CHAR(5) PRIMARY KEY CHECK([ID] LIKE 'CS[0-9][0-9][0-9]'),
	[Name] VARCHAR(255) CHECK([Name] LIKE 'Mr. %' OR [Name] LIKE 'Mrs. %'),
	[PhoneNumber] VARCHAR(13) NOT NULL,
	[Address] VARCHAR(255) CHECK([Address] LIKE '% Street' OR [Address] LIKE '% Road'),
	[Gender] VARCHAR(10) CHECK([Gender] LIKE 'FEMALE' OR [Gender] LIKE 'MALE'),
	[Email] VARCHAR(50) NOT NULL,
)

CREATE TABLE [Staff](
	[ID] CHAR(5) PRIMARY KEY CHECK([ID] LIKE 'ST[0-9][0-9][0-9]'),
	[Name] VARCHAR(255) CHECK(LEN([Name]) > 3),
	[PhoneNumber] VARCHAR(13) NOT NULL,
	[Address] VARCHAR(255) CHECK([Address] LIKE '% Street' OR [Address] LIKE '% Road'),
	[Gender] VARCHAR(10) CHECK([Gender] LIKE 'FEMALE' OR [Gender] LIKE 'MALE'),
	[Email] VARCHAR(50) NOT NULL,
	[Salary] INT NOT NULL,
)

CREATE TABLE [Supplier](
	[ID] CHAR(5) PRIMARY KEY CHECK([ID] LIKE 'SP[0-9][0-9][0-9]'),
	[Name] VARCHAR(255) CHECK([Name] LIKE 'Mr. %' OR [Name] LIKE 'Mrs. %'),
	[PhoneNumber] VARCHAR(13) NOT NULL,
	[Address] VARCHAR(255) CHECK([Address] LIKE '% Street' OR [Address] LIKE '% Road'),
	[Gender] VARCHAR(10) CHECK([Gender] LIKE 'FEMALE' OR [Gender] LIKE 'MALE'),
	[Email] VARCHAR(50) NOT NULL,
)

CREATE TABLE [BoatType](
	[ID] CHAR(5) PRIMARY KEY CHECK([ID] LIKE 'BT[0-9][0-9][0-9]'),
	[Name] VARCHAR(255) CHECK(LEN(NAME) > 5),
)

CREATE TABLE [Boat](
	[ID] CHAR(5) PRIMARY KEY CHECK([ID] LIKE 'BO[0-9][0-9][0-9]'),
	[BoatTypeID] CHAR(5) FOREIGN KEY REFERENCES [BoatType]([ID]),
	[Name] VARCHAR(255) NOT NULL,
	[RentPrice] INT NOT NULL,
	[PurchasePrice] INT NOT NULL,
)

CREATE TABLE [RentTransactionHeader](
	[ID] CHAR(5) PRIMARY KEY CHECK([ID] LIKE 'TR[0-9][0-9][0-9]'),
	[CustomerID] CHAR(5) FOREIGN KEY REFERENCES [Customer]([ID]),
	[StaffID] CHAR(5) FOREIGN KEY REFERENCES [Staff]([ID]),
	[TransactionTime] DATETIME DEFAULT(GETDATE()) CHECK(DATEPART(HOUR, [TransactionTime]) BETWEEN 9 AND 15),
)

CREATE TABLE [RentTransactionDetail](
	[RentTransactionHeaderID] CHAR(5) FOREIGN KEY REFERENCES [RentTransactionHeader]([ID]),
	[BoatID] CHAR(5) FOREIGN KEY REFERENCES [Boat]([ID]),
	[RentDuration] INT NOT NULL,
	PRIMARY KEY([RentTransactionHeaderID], [BoatID]),
)

CREATE TABLE [PurchaseTransactionHeader](
	[ID] CHAR(5) PRIMARY KEY CHECK([ID] LIKE 'TP[0-9][0-9][0-9]'),
	[StaffID] CHAR(5) FOREIGN KEY REFERENCES [Staff]([ID]),
	[SupplierID] CHAR(5) FOREIGN KEY REFERENCES [Supplier]([ID]),
	[TransactionTime] DATETIME DEFAULT(GETDATE()) CHECK(DATEPART(HOUR, [TransactionTime]) BETWEEN 9 AND 15),
)

CREATE TABLE [PurchaseTransactionDetail](
	[PurchaseTransactionHeaderID] CHAR(5) FOREIGN KEY REFERENCES [PurchaseTransactionHeader]([ID]),
	[BoatID] CHAR(5) FOREIGN KEY REFERENCES [Boat]([ID]),
	[Quantity] INT NOT NULL,
	PRIMARY KEY([PurchaseTransactionHeaderID], [BoatID]),
)

INSERT INTO [Customer]
	([ID]	, [Name]					 , [PhoneNumber], [Address]						, [Gender], [Email]						 ) VALUES
	('CS001', 'Mr. Dolores Abernathy'	 , '19828873440', '3222 Payton Mills Street'	, 'Male'  , 'flehner@oreilly.co.id'		 ),
	('CS002', 'Mrs. Michele Little III'	 , '15043966129', '762 Harber Spurs Road'		, 'Female', 'flarkin@gmail.com'			 ),
	('CS003', 'Mr. Kaitlyn Bogan DVM'	 , '4474782524' , '3429 Dameon Ports Street'	, 'Male'  , 'trent06@hotmail.co.id'		 ),
	('CS004', 'Mr. Kraig Kling'			 , '13655946617', '5482 Clarabelle Village Road', 'Male'  , 'oberbrunner.dave@littel.com'),
	('CS005', 'Mr. Davonte Ziemann'		 , '6166434968' , '8407 Carleton Track Street'	, 'Male'  , 'mayert.rosemary@hegmann.com'),
	('CS006', 'Mrs. Celine Konopelski'	 , '13568753105', '886 Koelpin Place Road'		, 'Female', 'ona23@mohr.co.id'			 ),
	('CS007', 'Mrs. Benton Turner'		 , '12574156589', '4486 Sawayn Lake Street'		, 'Female', 'leonie.dooley@bruen.co.id'	 ),
	('CS008', 'Mrs. Imelda Ankunding Jr.', '4402439489' , '8300 Ernser Mill Street'		, 'Female', 'elody.reinger@osinski.net'	 ),
	('CS009', 'Mr. Arnold'				 , '4713617678' , '7077 Daugherty Mill Road'	, 'Male'  , 'arnold75@wilderman.com'	 ),
	('CS010', 'Mr. Kirk Cummerata PhD'	 , '16758950407', '301 Lafayette Village Road'	, 'Male'  , 'uriah88@rau.co.id'			 )

INSERT INTO [Staff]
	([ID]	, [Name]				, [PhoneNumber], [Address]							, [Gender], [Email]						 , [Salary]) VALUES
	('ST001', 'Julianne'		    , '5589560434' , '35988 Ephraim Fall Road'			, 'Female', 'laney04@yahoo.com'			 ,  2500000),
	('ST002', 'Eldred Rogahn'		, '15149603660', '21903 Mya Curve Road'				, 'Male'  , 'ugibson@hotmail.com'		 ,  2500000),
	('ST003', 'Golden Reichel'		, '3417991182' , '8292 Crawford Branch Road'		, 'Female', 'vivienne.bergnaum@moen.com' ,  2500000),
	('ST004', 'Alexie Hartmann DDS' , '5467345658' , '213 Mertz Islands Street'			, 'Female', 'wilkinson.stewart@gmail.com',  2500000),
	('ST005', 'Olen Kuhn I'			, '9539962501' , '455 Bernadette Vista Road'		, 'Male'  , 'qokeefe@gmail.com'			 ,  2500000),
	('ST006', 'Maybell'		        , '4489335053' , '32848 Sylvester Causeway Street'	, 'Female', 'wjerde@hotmail.com'		 ,  2500000),
	('ST007', 'Dannie'		        , '19074361589', '7716 Lelah Square Street'			, 'Female', 'marian98@stanton.com'		 ,  2000000),
	('ST008', 'Reva'		        , '9314831083' , '23309 Alphonso Forks Street'		, 'Female', 'prosacco.obie@kuhic.org'	 ,  2000000),
	('ST009', 'Carole Goyette V'	, '9988718249' , '2503 Stanton River Road'			, 'Female', 'hyatt.serena@white.biz'	 ,  2500000),
	('ST010', 'Miller Murray'		, '15419139932', '7809 Kaylee Path Street'			, 'Male'  , 'morissette.flavie@mayer.org',  2500000)

INSERT INTO [Supplier]
	([ID]	, [Name]					 , [PhoneNumber], [Address]						  , [Gender], [Email]						) VALUES
	('SP001', 'Mrs. Vergie Orn DDS'		 , '4814327207' , '475 Corwin Via Road'			  , 'Female', 'sgislason@yahoo.com'			),
	('SP002', 'Mr. Verner Williamson DDS', '4182719523' , '879 Donnell Road'			  , 'Male'  , 'halvorson.daniella@gmail.com'),
	('SP003', 'Mr. Dax Veum'			 , '2393548470' , '5501 Jenifer Shoal Street'	  , 'Male'  , 'della87@osinski.com'			),
	('SP004', 'Mrs. Jennifer Lebsack'	 , '5927337850' , '32849 Greyson Turnpike Street' , 'Female', 'luettgen.nettie@klein.com'	),
	('SP005', 'Mrs. Aniyah Lubowitz II'	 , '18077449359', '50096 Vandervort Center Street', 'Female', 'stiedemann.lola@yahoo.com'	),
	('SP006', 'Mrs. Matilde Smitham'	 , '3196295579' , '22840 Waters Coves Street'	  , 'Female', 'toby36@hotmail.com'			),
	('SP007', 'Mr. Esteban Volkman'		 , '9839263134' , '83441 Johns Key Road'		  , 'Male'  ,  'vmaggio@jenkins.com'		),
	('SP008', 'Mr. Hyman McDermott'		 , '12398405625', '55948 Balistreri Causeway Road', 'Male'  , 'nkutch@wilderman.info'		),
	('SP009', 'Mrs. Katrine Howell'		 , '9303080485' , '60420 Alexane Rapid Road'	  , 'Female', 'ruecker.eldora@gmail.com'	),
	('SP010', 'Mr. Hyman Thompson III'	 , '19542569533', '48545 Alfred Crest Street'	  , 'Male'  , 'qgoyette@hayes.net'			)

INSERT INTO [BoatType]
	([ID]   , [Name]			) VALUES
	('BT001', 'Bow Rider'		),
	('BT002', 'Cruiser'			),
	('BT003', 'Fishing Vessel'	),
	('BT004', 'Fishing Boat'	),
	('BT005', 'Runabout'		),
	('BT006', 'Sailboat'		),
	('BT007', 'Speed Boat'		),
	('BT008', 'Pontoon Boat'	),
	('BT009', 'Trawler'			),
	('BT010', 'Watersport Boat'	)

INSERT INTO [Boat]
	([ID]	, [BoatTypeID], [Name]			 ,   [RentPrice],	  [PurchasePrice]) VALUES
	('BO001', 'BT001'	  , 'Bow Rider'		 ,		  160000,			   800000),
	('BO002', 'BT002'	  , 'Cruiser'		 ,		20000000,			100000000),
	('BO003', 'BT003'	  , 'Fishing Vessel' ,		  500000,			  4000000),
	('BO004', 'BT004'	  , 'Fishing Boat'	 ,		  100000,			  2000000),
	('BO005', 'BT005'	  , 'Runabout'		 ,		  100000,			  2000000),
	('BO006', 'BT006'	  , 'Sailboat'		 ,		  150000,			  2500000),
	('BO007', 'BT007'	  , 'Speed Boat'	 ,		  200000,			  4000000),
	('BO008', 'BT008'	  , 'Pontoon Boat'	 ,		  100000,			  2000000),
	('BO009', 'BT009'	  , 'Trawler'		 ,		  150000,			  3500000),
	('BO010', 'BT010'	  , 'Watersport Boat',		  200000,			  4000000)

INSERT INTO [PurchaseTransactionHeader]
	([ID]   , [StaffID], [SupplierID], [TransactionTime]    ) VALUES
	('TP001', 'ST008'     , 'SP002'  , '2018-11-25 11:00:00'),
	('TP002', 'ST003'     , 'SP007'  , '2018-06-18 10:00:00'),
	('TP003', 'ST001'     , 'SP005'  , '2018-12-07 09:00:00'),
	('TP004', 'ST005'     , 'SP006'  , '2018-07-30 09:00:00'),
	('TP005', 'ST005'     , 'SP009'  , '2018-08-21 13:00:00'),
	('TP006', 'ST004'     , 'SP002'  , '2018-09-09 13:00:00'),
	('TP007', 'ST006'     , 'SP002'  , '2018-08-07 11:00:00'),
	('TP008', 'ST006'     , 'SP006'  , '2018-06-25 11:00:00'),
	('TP009', 'ST005'     , 'SP006'  , '2018-02-01 11:00:00'),
	('TP010', 'ST009'     , 'SP003'  , '2018-01-27 11:00:00'),
	('TP011', 'ST009'     , 'SP009'  , '2018-02-03 09:00:00'),
	('TP012', 'ST006'     , 'SP002'  , '2018-07-03 10:00:00'),
	('TP013', 'ST005'     , 'SP006'  , '2018-03-16 11:00:00'),
	('TP014', 'ST002'     , 'SP005'  , '2018-05-18 11:00:00'),
	('TP015', 'ST009'     , 'SP005'  , '2018-04-29 11:00:00')

INSERT INTO [PurchaseTransactionDetail]
	([PurchaseTransactionHeaderID], [BoatID], [Quantity]) VALUES
	('TP001'                      , 'BO001' , 5         ),
	('TP001'                      , 'BO003' , 3         ),
	('TP001'                      , 'BO008' , 2         ),
	('TP002'                      , 'BO001' , 1         ),
	('TP002'                      , 'BO002' , 3         ),
	('TP003'                      , 'BO005' , 8         ),
	('TP003'                      , 'BO009' , 7         ),
	('TP004'                      , 'BO001' , 2         ),
	('TP004'                      , 'BO008' , 4         ),
	('TP005'                      , 'BO004' , 5         ),
	('TP005'                      , 'BO007' , 2         ),
	('TP005'                      , 'BO009' , 6         ),
	('TP006'                      , 'BO006' , 8         ),
	('TP007'                      , 'BO004' , 8         ),
	('TP008'                      , 'BO008' , 4         ),
	('TP009'                      , 'BO010' , 4         ),
	('TP010'                      , 'BO003' , 1         ),
	('TP010'                      , 'BO005' , 7         ),
	('TP010'                      , 'BO006' , 1         ),
	('TP010'                      , 'BO008' , 7         ),
	('TP011'                      , 'BO005' , 4         ),
	('TP012'                      , 'BO004' , 5         ),
	('TP013'                      , 'BO002' , 5         ),
	('TP014'                      , 'BO008' , 7         ),
	('TP015'                      , 'BO010' , 7         )

INSERT INTO [RentTransactionHeader]
	([ID]   , [CustomerID], [StaffID], [TransactionTime]    ) VALUES
	('TR001', 'CS007'     , 'ST002'  , '2017-01-20 13:00:00'),
	('TR002', 'CS003'     , 'ST001'  , '2017-05-17 11:00:00'),
	('TR003', 'CS008'     , 'ST010'  , '2017-12-04 10:00:00'),
	('TR004', 'CS007'     , 'ST008'  , '2017-04-11 09:00:00'),
	('TR005', 'CS010'     , 'ST006'  , '2017-03-24 12:00:00'),
	('TR006', 'CS002'     , 'ST005'  , '2017-01-27 12:00:00'),
	('TR007', 'CS010'     , 'ST003'  , '2018-10-19 13:00:00'),
	('TR008', 'CS009'     , 'ST005'  , '2018-09-22 14:00:00'),
	('TR009', 'CS003'     , 'ST008'  , '2018-11-22 14:00:00'),
	('TR010', 'CS003'     , 'ST001'  , '2018-05-26 13:00:00'),
	('TR011', 'CS008'     , 'ST006'  , '2018-03- 4 13:00:00'),
	('TR012', 'CS004'     , 'ST004'  , '2018-09-22 10:00:00'),
	('TR013', 'CS001'     , 'ST006'  , '2018-02-24 14:00:00'),
	('TR014', 'CS006'     , 'ST003'  , '2018-03-28 14:00:00'),
	('TR015', 'CS005'     , 'ST005'  , '2018-06-14 14:00:00')

INSERT INTO [RentTransactionDetail]
	([RentTransactionHeaderID], [BoatID], [RentDuration]) VALUES
	('TR001'                  , 'BO007' , 10            ),
	('TR002'                  , 'BO001' , 8             ),
	('TR003'                  , 'BO001' , 8             ),
	('TR003'                  , 'BO003' , 4             ),
	('TR003'                  , 'BO006' , 5             ),
	('TR004'                  , 'BO003' , 7             ),
	('TR005'                  , 'BO001' , 9             ),
	('TR006'                  , 'BO005' , 10            ),
	('TR006'                  , 'BO007' , 8             ),
	('TR007'                  , 'BO004' , 8             ),
	('TR007'                  , 'BO006' , 10            ),
	('TR007'                  , 'BO010' , 6             ),
	('TR008'                  , 'BO009' , 9             ),
	('TR009'                  , 'BO002' , 8             ),
	('TR009'                  , 'BO005' , 6             ),
	('TR010'                  , 'BO009' , 7             ),
	('TR011'                  , 'BO008' , 4             ),
	('TR011'                  , 'BO009' , 6             ),
	('TR012'                  , 'BO003' , 5             ),
	('TR012'                  , 'BO010' , 6             ),
	('TR013'                  , 'BO008' , 4             ),
	('TR014'                  , 'BO006' , 7             ),
	('TR014'                  , 'BO004' , 5             ),
	('TR014'                  , 'BO008' , 8             ),
	('TR015'                  , 'BO003' , 8             )


BEGIN TRAN --RentTransaction

	INSERT INTO RentTransactionHeader VALUES
	('TR016', 'CS003', 'ST002', '2018-12-14 12:00:00')

	--INSERT INTO RentTransactionHeader (ID, CustomerID, StaffID)VALUES
	--('TR016', 'CS003', 'ST002')

	INSERT INTO RentTransactionDetail VALUES
	('TR016', 'BO001', 3),
	('TR016', 'BO002', 3),
	('TR016', 'BO003', 3)

	SELECT * FROM RentTransactionHeader rth JOIN
	RentTransactionDetail rtd ON rth.ID = rtd.RentTransactionHeaderID

ROLLBACK

BEGIN TRAN --PurchaseTransaction

	INSERT INTO PurchaseTransactionHeader VALUES
	('TP016', 'ST003', 'SP002', '2018-12-14 12:00:00')

	--INSERT INTO PurchaseTransactionHeader (ID, StaffID, SupplierID)VALUES
	--('TP016', 'ST003', 'SP002')

	INSERT INTO PurchaseTransactionDetail VALUES
	('TP016', 'BO001', 3),
	('TP016', 'BO002', 2),
	('TP016', 'BO003', 5)

	SELECT * FROM PurchaseTransactionHeader pth JOIN
	PurchaseTransactionDetail ptd ON pth.ID = ptd.PurchaseTransactionHeaderID

ROLLBACK

--1
SELECT
	[CustomerID] = c.ID,
	[Total Rent Transaction] = COUNT(*)
FROM [Customer] c
	JOIN [RentTransactionHeader] rth ON c.ID = rth.CustomerID
WHERE
	c.Email LIKE '%.co.id' AND
	c.Gender = 'Male'
GROUP BY c.ID
ORDER BY COUNT(*) ASC

--2
SELECT
	[BoatSupplierName] = s.[Name],
	[TransactionDate] = pth.TransactionTime,
	[Total Boat Quantity] = SUM(ptd.Quantity)
FROM [Supplier] s
	JOIN [PurchaseTransactionHeader] pth ON s.ID = pth.SupplierID
	JOIN [PurchaseTransactionDetail] ptd ON pth.ID = ptd.PurchaseTransactionHeaderID
WHERE MONTH(pth.TransactionTime) = 3
GROUP BY s.[Name], pth.TransactionTime
HAVING SUM(ptd.Quantity) > 1

--3
SELECT
	[RentID] = rth.ID,
	[CustomerName] = c.[Name],
	[StaffName] = s.[Name],
	[Total Transaction] = COUNT(*),
	[Total Rent Duration] = SUM(rtd.RentDuration)
FROM [RentTransactionHeader] rth
	JOIN [Customer] c ON c.ID = rth.CustomerID
	JOIN [Staff] s ON s.ID = rth.StaffID
	JOIN [RentTransactionDetail] rtd ON rtd.RentTransactionHeaderID = rth.ID
WHERE c.[Name] LIKE 'Mr.%'
GROUP BY rth.ID, c.[Name], s.[Name]
HAVING SUM(rtd.RentDuration) > 6

--4
SELECT
	[TransactionDate] = TransactionTime,
	[CustomerName] = c.[Name],
	[StaffName] = s.[Name],
	[Total of Rent Duration] = SUM(rtd.RentDuration),
	[Maximum Rent Duration] = MAX(rtd.RentDuration)
FROM RentTransactionHeader rth
	JOIN [Customer] c ON c.ID = rth.CustomerID
	JOIN [Staff] s ON s.ID = rth.StaffID
	JOIN [RentTransactionDetail] rtd ON rtd.RentTransactionHeaderID = rth.ID
WHERE
	(DATEPART(HOUR, TransactionTime) BETWEEN 9 AND 11) AND
	LEN(s.[Name]) > 10
GROUP BY TransactionTime, c.[Name], s.[Name]

--5
SELECT
	[BoatSupplierID] = su.ID,
	[StaffName] = st.[Name],
	[Quantity] = CAST(Quantity AS VARCHAR) + ' boat',
	[Date] = FORMAT(CAST(TransactionTime AS DATE), 'dd MMM yyyy')
FROM [PurchaseTransactionHeader] pth
	JOIN [Staff] st ON st.ID = pth.StaffID
	JOIN [Supplier] su ON su.ID = pth.SupplierID
	JOIN [PurchaseTransactionDetail] ptd ON ptd.PurchaseTransactionHeaderID = pth.ID,
	(
		SELECT Average = AVG(Salary)
		FROM [Staff]
	) x
WHERE
	CHARINDEX(' ', st.[Name]) = 0 AND
	st.Salary < x.Average

--6
SELECT
	[RentID] = rth.ID,
	[TransactionDate] = rth.TransactionTime,
	[StaffName] = s.[Name],
	[Rent Transaction Duration] = CAST(rtd.RentDuration AS VARCHAR) + ' hour(s)'
FROM RentTransactionHeader rth
	JOIN Staff s ON s.ID = rth.StaffID
	JOIN RentTransactionDetail rtd ON rth.ID = rtd.RentTransactionHeaderID,
	(
		SELECT Average = AVG(DATEDIFF(DAY, GETDATE(), rth.TransactionTime))
		FROM [RentTransactionHeader] rth
	) x
WHERE
	s.Gender = 'Male' AND
	DATEDIFF(DAY, GETDATE(), rth.TransactionTime) > x.Average

--7
SELECT
	[Boat Type Name] = UPPER(bt.[Name]),
	[Total Purchase Quantity] = SUM(Quantity)
FROM PurchaseTransactionHeader pth
	JOIN PurchaseTransactionDetail ptd ON ptd.PurchaseTransactionHeaderID = pth.ID
	JOIN Boat b ON b.ID = ptd.BoatID
	JOIN BoatType bt ON bt.ID = b.BoatTypeID,
	(
		SELECT Average = AVG(ptd.Quantity)
		FROM PurchaseTransactionDetail ptd
	) x
GROUP BY bt.[Name], x.Average
HAVING
	AVG(Quantity) < x.Average AND
	SUM(Quantity) = 2

--8
SELECT
	[RentID] = rth.ID,
	[StaffName] = s.[Name],
	[Transaction Month] = FORMAT(CAST(TransactionTime AS DATE), 'MMM'),
	[Total Rent Duration] = CAST(SUM(rtd.RentDuration) AS VARCHAR) + ' hour(s)',
	[Average Rent Duration] = CAST(AVG(rtd.RentDuration) AS VARCHAR) + ' hour(s)'
FROM RentTransactionHeader rth
	JOIN RentTransactionDetail rtd ON rtd.RentTransactionHeaderID = rth.ID
	JOIN Staff s ON s.ID = rth.StaffID,
	(
		SELECT Average = AVG(rtd.RentDuration)
		FROM RentTransactionDetail rtd
	) x
WHERE
	rtd.RentDuration > x.Average AND
	YEAR(rth.TransactionTime) = 2017
GROUP BY rth.ID, s.[Name], TransactionTime, x.Average, rth.TransactionTime

--9
CREATE OR ALTER VIEW RentTransactionData AS SELECT
	[RentID] = rth.ID,
	[Date] = FORMAT(CAST(TransactionTime AS DATE), 'dd MMM yyyy'),
	[Total Hours] = SUM(rtd.RentDuration),
	[Total Rent Transaction] = COUNT(*)
FROM RentTransactionHeader rth
	JOIN RentTransactionDetail rtd ON rtd.RentTransactionHeaderID = rth.ID
	JOIN Boat b ON rtd.BoatID = b.ID
WHERE
	b.RentPrice < 20000000
GROUP BY rth.ID, TransactionTime
HAVING SUM(rtd.RentDuration) > 5

--10
CREATE OR ALTER VIEW PurchaseTransactionData AS SELECT
	[Transaction ID] = REPLACE(pth.ID, 'TP', 'PUR'),
	[TransactionDate] = pth.TransactionTime,
	[BoatSupplierName] = s.[Name],
	[Total Quantity] = SUM(ptd.Quantity),
	[Max Amount of Quantity] = MAX(ptd.Quantity)
FROM PurchaseTransactionHeader pth
	JOIN PurchaseTransactionDetail ptd ON ptd.PurchaseTransactionHeaderID = pth.ID
	JOIN Supplier s ON s.ID = pth.SupplierID
GROUP BY pth.ID, pth.TransactionTime, s.[Name]
HAVING
	SUM(ptd.Quantity) < 5 AND
	MAX(ptd.Quantity) > 1