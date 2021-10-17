CREATE DATABASE Musica
go
use Musica

--DROP DATABASE Musica

/*
DROP TABLE DetailTransaction
DROP TABLE HeaderTransaction
DROP TABLE MsMusicIns
DROP TABLE MsMusicInsType
DROP TABLE MsEmployee
DROP TABLE MsBranch
*/

CREATE TABLE MsBranch
(
	BranchID VARCHAR(6) PRIMARY KEY,
	BranchName VARCHAR(50) NOT NULL,
	Address VARCHAR(100) NOT NULL,
	Phone VARCHAR(50),
	CONSTRAINT CheckBran1 CHECK (LEN(BranchID)=5),
	CONSTRAINT CheckBran2 CHECK (BranchID LIKE 'BR[0-9][0-9][0-9]')
)

CREATE TABLE MsEmployee
(
	EmployeeID VARCHAR(6) PRIMARY KEY,
	EmployeeName VARCHAR(50) NOT NULL,
	Address VARCHAR(100) NOT NULL,
	Phone VARCHAR(50),
	Gender CHAR(3) NOT NULL,
	DateOfBirth DATETIME,
	Salary NUMERIC,
	BranchID VARCHAR(6) REFERENCES MsBranch ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT CheckEmpl1 CHECK (LEN(EmployeeID)=5),
	CONSTRAINT CheckEmpl2 CHECK (EmployeeID LIKE 'EM[0-9][0-9][0-9]'),
	CONSTRAINT CheckEmpl3 CHECK (Gender IN ('M','F'))
)

CREATE TABLE MsMusicInsType
(
	MusicInsTypeID VARCHAR(6) PRIMARY KEY,
	MusicInsType VARCHAR(50) NOT NULL,	 
	CONSTRAINT CheckMsct1 CHECK (LEN(MusicInsTypeID)=5),
	CONSTRAINT CheckMsct2 CHECK (MusicInsTypeID LIKE 'MT[0-9][0-9][0-9]')
)

CREATE TABLE MsMusicIns
(
	MusicInsID VARCHAR(6) PRIMARY KEY,
	MusicIns VARCHAR(50) NOT NULL,
	Price NUMERIC NOT NULL,
	Stock INT NOT NULL,
	MusicInsTypeID VARCHAR(6) REFERENCES MsMusicInsType ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT CheckMsci1 CHECK (LEN(MusicInsID)=5),
	CONSTRAINT CheckMsci2 CHECK (MusicInsID LIKE 'MI[0-9][0-9][0-9]'),
	CONSTRAINT CheckMsci3 CHECK (Stock >= 0)
)

CREATE TABLE HeaderTransaction
(
	TransactionID VARCHAR(6) PRIMARY KEY,
	TransactionDate DATETIME NOT NULL,
	EmployeeID VARCHAR(6) REFERENCES MsEmployee ON UPDATE CASCADE ON DELETE SET NULL,
	CustomerName VARCHAR(50),
	CONSTRAINT CheckHead1 CHECK (LEN(TransactionID)=5),
	CONSTRAINT CheckHead2 CHECK (TransactionID LIKE 'TR[0-9][0-9][0-9]')
)

CREATE TABLE DetailTransaction
(
	TransactionID VARCHAR(6) REFERENCES HeaderTransaction ON UPDATE CASCADE ON DELETE CASCADE,
	MusicInsID VARCHAR(6) REFERENCES MsMusicIns ON UPDATE CASCADE ON DELETE CASCADE,
	Qty INT NOT NULL,
	PRIMARY KEY(TransactionID, MusicInsID)
)

insert into MsBranch values ('BR001','Cabang Merdeka','Jl. Gang Merdeka No. 17','021-7771234')
insert into MsBranch values ('BR002','Cabang Sejahtera','Jl. Sejahtera Sehat Selalu No. 88','022-2008972')
insert into MsBranch values ('BR003','Cabang Adil','Jl. Adil No. 33','021-8983234')
insert into MsBranch values ('BR004','Cabang Makmur','Jl. Gang Makmur No. 12','021-6526321')
insert into MsBranch values ('BR005','Cabang Damai','Jl. Damai Aman Sentosa No. 45','044-8989898')

insert into MsEmployee values ('EM001','Kikis Sabrina Mona','Jl. Putar-Putar No. 8','022-1239995','F','1989-03-21','3500000','BR003')
insert into MsEmployee values ('EM002','Marlene Martani','Jl. Gajebo No. 32','022-5675542','F','1988-06-14','4250000','BR002')
insert into MsEmployee values ('EM003','Rakhmat Suryahadi','Gang Gansing No. 19','021-3451232','M','1988-01-30','3670000','BR002')
insert into MsEmployee values ('EM004','Suhandi','Jl. Pintu Lima No. 5','022-4519377','M','1985-02-10','5600000','BR001')
insert into MsEmployee values ('EM005','Lisye Mareta Cahya','Jl. Gang Medan Merdeka No. 25','021-9798123','F','1986-12-12','5400000','BR001')
insert into MsEmployee values ('EM006','Sofian Chandra','Jl. Putar-Putar No. 12','021-8763445','M','1987-12-11','5500000','BR005')
insert into MsEmployee values ('EM007','William Salim','Jl. Pusing-Pusing No. 76','022-4859345','M','1987-08-14','5490000','BR005')
insert into MsEmployee values ('EM008','William Wijaya','Jl. Gichung No. 10','022-7859123','M','1989-11-04','5590000','BR003')

insert into MsMusicInsType values ('MT001','Guitar')
insert into MsMusicInsType values ('MT002','Violin')
insert into MsMusicInsType values ('MT003','Piano')
insert into MsMusicInsType values ('MT004','Drum')
insert into MsMusicInsType values ('MT005','Keyboard')

insert into MsMusicIns values ('MI001','Yamaha CX-40','1150000','23','MT001')
insert into MsMusicIns values ('MI002','Yamaha KX-5000','5950000','12','MT005')
insert into MsMusicIns values ('MI003','Yamaha C-390','1250000','10','MT001')
insert into MsMusicIns values ('MI004','Excellent P-77','25700000','17','MT003')
insert into MsMusicIns values ('MI005','Board B-123','5650000','30','MT005')
insert into MsMusicIns values ('MI006','Pearl Q-300','9570000','26','MT004')
insert into MsMusicIns values ('MI007','Supernova X-23','4510000','56','MT002')
insert into MsMusicIns values ('MI008','Yamaha Grand X-1','49750000','12','MT003')

insert into HeaderTransaction values ('TR001','2010-10-02 15:30:00.000','EM003','Veronica')
insert into HeaderTransaction values ('TR002','2010-10-15 09:50:00.000','EM008','Richard Parker')
insert into HeaderTransaction values ('TR003','2010-10-16 13:26:00.000','EM005','Steven Michael')
insert into HeaderTransaction values ('TR004','2010-11-22 10:55:00.000','EM004','Anabelle Setiawan Wati')
insert into HeaderTransaction values ('TR005','2010-11-25 15:30:00.000','EM003','Michelle Regina')
insert into HeaderTransaction values ('TR006','2010-12-13 08:23:00.000','EM001','Dian Sastro')
insert into HeaderTransaction values ('TR007','2010-12-13 18:19:00.000','EM001','Cathy')
insert into HeaderTransaction values ('TR008','2010-12-27 15:21:00.000','EM006','Stephanie Meyer')
insert into HeaderTransaction values ('TR009','2010-01-02 10:28:00.000','EM007','Michael J.')
insert into HeaderTransaction values ('TR010','2010-01-03 12:39:00.000','EM002','Arnold Swasana Segar')

insert into DetailTransaction values ('TR001','MI001','1')
insert into DetailTransaction values ('TR001','MI004','2')
insert into DetailTransaction values ('TR002','MI003','1')
insert into DetailTransaction values ('TR002','MI005','2')
insert into DetailTransaction values ('TR002','MI008','5')
insert into DetailTransaction values ('TR003','MI007','4')
insert into DetailTransaction values ('TR004','MI004','3')
insert into DetailTransaction values ('TR004','MI006','3')
insert into DetailTransaction values ('TR005','MI002','1')
insert into DetailTransaction values ('TR006','MI001','2')
insert into DetailTransaction values ('TR007','MI003','3')
insert into DetailTransaction values ('TR007','MI006','5')
insert into DetailTransaction values ('TR008','MI002','3')
insert into DetailTransaction values ('TR008','MI004','2')
insert into DetailTransaction values ('TR008','MI008','1')
insert into DetailTransaction values ('TR009','MI002','2')
insert into DetailTransaction values ('TR009','MI005','4')
insert into DetailTransaction values ('TR010','MI001','2')
insert into DetailTransaction values ('TR010','MI003','2')
insert into DetailTransaction values ('TR010','MI004','2')

select * from MsBranch
select * from MsEmployee
select * from MsMusicIns
select * from MsMusicInsType
select * from HeaderTransaction
select * from DetailTransaction



--Menampilkan top 2 dariEmployeeID, EmployeeName, Gender dimana Gender adalah 'F' 
SELECT TOP(2) MsEmployee.EmployeeID, MsEmployee.EmployeeName, MsEmployee.Gender
FROM MsEmployee
WHERE MsEmployee.Gender LIKE 'F'

--Menampilkan tabel MsEmployee dimana digit terakhir dari Phone adalah kelipatan 5 dan salary lebih besar dari 4000000
Select * FROM MsEmployee
Where Right(MsEmployee.Phone, 1) % 5 = 0
AND MsEmployee.Salary > 4000000

--Membuat view dengan nama view_1 lalu tampilkan tabel MsMusicIns dimana price antara 5000000 dan 10000000, dengan MusicIns diawali dengan kata Yamaha.
Create view view_1 AS
Select *
From MsMusicIns
Where MsMusicIns.MusicIns Like 'Yamaha%'
And MsMusicIns.Price Between 5000000 And 10000000

Select * From view_1
Drop view view_1

--Menampilkan BranchEmployee ( didapat dari employeename dan nama depan employeename diganti dengan branchID ) dimana employeename memiliki minimal 3 kata.
Select Replace(MsEmployee.EmployeeName, Substring(MsEmployee.EmployeeName, 1, Charindex(' ', MsEmployee.EmployeeName)-1), MsBranch.BranchID) As 'Branch Employee'
From MsEmployee
Join MsBranch
ON MsBranch.BranchID = MsEmployee.BranchID
Where MsEmployee.EmployeeName Like '% % %'


--Menampilkan Brand (didapat dari kata pertama MusicIns), Price (didapat dari price ditambahkan kata 'Rp. ' didepannya), Stock, Instrument Type(didapat dari MusicInsType)
Select Substring(MsMusicIns.MusicIns, 1, Charindex(' ', MsMusicIns.MusicIns)-1) AS 'Brand',
	[Price] = 'Rp ' + CAST(MsMusicIns.Price AS Varchar(255)), MsMusicIns.Stock, MsMusicInsType.MusicInsType AS 'Instrument Type'
From MsMusicIns
Join MsMusicInsType 
ON MsMusicIns.MusicInsTypeID = MsMusicInsType.MusicInsTypeID


--Membuat store procedure untuk fungsi search dengan nama search yang menampilkan EmployeeName, Address, Phone, Gender. Fungsi ini akan mencari ke seluruh kolom sesuai inputan.
Create procedure search
@input Varchar(255)
AS
Begin
	Select MsEmployee.EmployeeName, MsEmployee.Address, MsEmployee.Phone, MsEmployee.Gender
	From MsEmployee
	Where MsEmployee.EmployeeName Like '%'+ @input +'%' OR
	MsEmployee.Address Like '%'+ @input +'%' OR
	MsEmployee.Phone Like '%'+ @input +'%' OR
	MsEmployee.Gender Like '%'+ @input +'%'
End

Exec search 'lim'
Exec search '19'
Exec search 'F'

--Membuat Stored Procedure dengan nama “Check_Transaction” yang menampilkan data CustomerName, EmployeeName, BranchName, MusicIns, Price berdasarkan TransactionID yang diinput.
CREATE PROCEDURE Check_Transaction @transactID VARCHAR(55) AS
SELECT HeaderTransaction.CustomerName, MsEmployee.EmployeeName, MsBranch.BranchName, MsMusicIns.MusicIns, MsMusicIns.Price
FROM MsBranch
JOIN MsEmployee
ON MsEmployee.BranchID = MsBranch.BranchID
JOIN HeaderTransaction
ON HeaderTransaction.EmployeeID = MsEmployee.EmployeeID
JOIN DetailTransaction
ON HeaderTransaction.TransactionID = DetailTransaction.TransactionID
JOIN MsMusicIns
ON MsMusicIns.MusicInsID = DetailTransaction.MusicInsID
WHERE HeaderTransaction.TransactionID = @transactID


EXEC Check_Transaction @transactID = 'TR001'


--Menampilkan data yang menunjukan detail jumlah transaksi musicins per employee
SELECT COUNT(DetailTransaction.TransactionID) AS 'Jumlah Transaksi', MsEmployee.EmployeeName
FROM MsEmployee
JOIN HeaderTransaction
ON HeaderTransaction.EmployeeID = MsEmployee.EmployeeID
JOIN DetailTransaction
ON DetailTransaction.TransactionID = HeaderTransaction.TransactionID
GROUP BY MsEmployee.EmployeeName

--Membuat Stored Procedure dengan nama "Add_Stock_MusicIns" untuk menambah stock MusicIns. Jika stock yang diinput lebih kecil atau sama dengan 0, maka akan dimunculkan pesan "Stok yang di input harus lebih besar dari 0"
Create Procedure Add_Stock_MusicIns
@id Varchar(255),
@Stock Varchar(20)
AS
Begin
	IF(@Stock <=0)
		Begin
			Print 'Stok yang di input harus lebih besar dari 0'
		End
	Else
		Begin
			Update MsMusicIns
			Set Stock = Stock + @Stock
			Where MsMusicIns.MusicInsID = @id
		End
End

Add_Stock_MusicIns'MI001','0'
Add_Stock_MusicIns'MI001','2'

--Membuat Store Procedure dengan nama "Check_Music_Code" yang digunakan untuk menampilkan informasi dari kode yang dimasukan. Kode yang dimasukan berupa MusicInsID atau MusicInsTypeID,  jika kode yang dimasukan tidak terdaftar atau salah maka akan ditampilkan pesan "Data tidak ditemukan / Kode yang dimasukan salah"
Create Procedure Check_Music_Code 
@musicinsid Varchar(50)
AS
Begin
Declare @wadahmusic_ins_Id Varchar(50)
Declare @wadahmusic_ins_type_id Varchar(50)
Declare @wadahsemuamusic1 Varchar(255)
Declare @wadahsemuamusictypeid Varchar(255)
Select @wadahmusic_ins_Id = MusicInsID FROM MsMusicIns
Where MusicInsID = @musicinsid

SELECT @wadahmusic_ins_type_id = MusicInsTypeID FROM MsMusicInsType
WHERE MsMusicInsType.MusicInsTypeID = @musicinsid

Select @wadahsemuamusic1 = MsMusicIns.MusicInsID FROM MsMusicIns
Select @wadahsemuamusictypeid = MsMusicInsType.MusicInsTypeID FROM MsMusicInsType
	
	If(@musicinsid = @wadahmusic_ins_type_id)
	Begin
	Select MsMusicInsType.MusicInsTypeID, MsMusicInsType.MusicInsType
	FROM MsMusicInsType
	WHERE MsMusicInsType.MusicInsTypeID = @musicinsid
	End
	Else if(@musicinsid = @wadahmusic_ins_Id)
	Begin
	Select * FROM MsMusicIns
	WHERE MsMusicIns.MusicInsID = @musicinsid
	End
	Else if(@musicinsid <> @wadahsemuamusic1 AND @musicinsid <> @wadahsemuamusictypeid OR @musicinsid IS NULL)
	Begin
	Print 'Data tidak ditemukan / Kode yang dimasukan salah'
	End
End

Execute Check_Music_Code'MT001'
Execute Check_Music_Code'MI001'

--Membuat Stored Procedure dengan nama “Check_Sale” untuk melihat MusicInsType apa saja yang terjual pada bulan tertentu beserta jumlah yang terjualnya.
Create procedure Check_Sale
@Month Varchar(255)
AS
Begin
	Select MsMusicInsType.MusicInsType, DetailTransaction.Qty
	FROM MsMusicInsType
	JOIN MsMusicIns
	ON MsMusicIns.MusicInsTypeID = MsMusicInsType.MusicInsTypeID
	JOIN DetailTransaction
	ON MsMusicIns.MusicInsID = DetailTransaction.MusicInsID
	JOIN HeaderTransaction
	ON HeaderTransaction.TransactionID = DetailTransaction.TransactionID
	Where DATENAME(MONTH, HeaderTransaction.TransactionDate) LIKE @Month
End

Exec Check_Sale 'November'


--Membuat Stored Procedured dengan nama “Check_Employee” yang berfungsi untuk memberikan informasi employeename, address, phone, DateOfBirth, dan BranchName berdasarkan TransactionID. Jika TransactionID tidak dimasukan, maka akan dimunculkan semua data employee yang ada.
Create procedure Check_Employee
@transasction_Id Varchar(255)
AS
Begin

	Declare @wadahtransact Varchar(50)
	Select @wadahtransact = HeaderTransaction.TransactionID
	FROM HeaderTransaction
	Where HeaderTransaction.TransactionID = @transasction_Id
	
	If(@transasction_Id = @wadahtransact)
	Begin
		Select MsEmployee.EmployeeName, MsEmployee.Address, MsEmployee.Phone, MsEmployee.DateOfBirth, MsBranch.BranchName FROM MsEmployee
		JOIN MsBranch
		ON MsBranch.BranchID = MsEmployee.BranchID
		Where MsEmployee.EmployeeID IN(
		Select HeaderTransaction.EmployeeID
		FROM HeaderTransaction
		Where HeaderTransaction.TransactionID = @transasction_Id)
	End
	Else
	Begin
		Select MsEmployee.EmployeeName, MsEmployee.Address, MsEmployee.Phone, MsEmployee.DateOfBirth, MsBranch.BranchName FROM MsEmployee
		JOIN MsBranch
		ON MsBranch.BranchID = MsEmployee.BranchID
	End
End

Exec Check_Employee 'Tr001'
Execute Check_Employee 'Treee'



