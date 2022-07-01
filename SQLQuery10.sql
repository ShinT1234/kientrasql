
--1.Tạo cơ sở dữ liệu
CREATE DATABASE AZBank	
GO 
USE AZBank
GO
--Tạo Bảng khách hàng
CREATE TABLE Customer(
	CustomerID int PRIMARY KEY,
	Name nvarchar(40) NULL,
	City nvarchar(40) NULL,
	Country nvarchar(40) NULL,
	Phone nvarchar(40) NULL,
	Email nvarchar(40) NULL
)
GO
--Tạo bảng Tài khoản khách hàng
CREATE TABLE CustomerAccount(
	AccountNumber char(9) PRIMARY KEY,
	CustomerID int CONSTRAINT fk FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	Balance money,
	MinAccount money NULL
)
GO
--Tạo bảng Giao dịch khách hàng
CREATE TABLE CustomerTransaction(
	TransactionID int PRIMARY KEY,
	AccountNumber char(9) CONSTRAINT ck FOREIGN KEY (AccountNumber) REFERENCES CustomerAccount(AccountNumber) NULL,
	TransactionDate smalldatetime NULL,
	Amount money NULL,
	DepositorWithdraw bit NULL
)
GO
SELECT * FROM Customer
SELECT * FROM CustomerAccount
SELECT * FROM CustomerTransaction
GO
--Chèn điều kiện về số tiền 
ALTER TABLE CustomerTransaction
ADD CONSTRAINT so_tien CHECK (Amount>0 AND Amount <=1000000);
--Chèn vào bảng ghi
INSERT INTO Customer(CustomerID,Name,City,Country,Phone,Email)
	VALUES (1,N'Đỗ Đức Manh',N'Vĩnh Phúc',N'Việt Nam',0973429784,N'domanhcca@gmail.com'),
	       (2,N'Nguyễn Bá Quốc',N'Hà Nội',N'Việt Nam',0973429785,N'quoc123@gmail.com'),
		   (3,N'Mai Xuân Tiến',N'Hà Nội',N'Việt Nam',0973429786,N'tien123@gmail.com')

INSERT INTO CustomerAccount(AccountNumber,CustomerID,Balance,MinAccount)
	VALUES (123456789,1,10000000,50000),
		   (234567891,2,15000000,50000),
		   (345678912,3,20000000,50000)
INSERT INTO CustomerTransaction (TransactionID,AccountNumber,TransactionDate,Amount,DepositorWithdraw)
	VALUES (1,123456789,'1-7-2022',900000,1),
		   (2,234567891,'2-7-2022',150000,2),
		   (3,345678912,'3-7-2022',200000,1)
GO 
--Truy vấn tất cả khách hàng ở hà nội
SELECT *FROM Customer
	WHERE City=N'Hà Nội'
--Create a view named vCustomerTransactions that display Name,AccountNumber, TransactionDate, Amount, and DepositorWithdraw from Customer,CustomerAccount and CustomerTransaction tables.
go
create view vCustomerTransaction as
SELECT Customer.Name,CustomerAccount.AccountNumber,CustomerTransaction.TransactionDate,CustomerTransaction.Amount,CustomerTransaction.DepositorWithdraw
FROM Customer join CustomerAccount on Customer.CustomerID=CustomerAccount.CustomerID 
join CustomerTransaction on CustomerAccount.AccountNumber=CustomerTransaction.AccountNumber
select * from vCustomerTransaction