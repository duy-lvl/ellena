CREATE DATABASE Ellena

GO

USE Ellena

GO

CREATE TABLE tblRoles(
	roleID   nvarchar(10) PRIMARY KEY,
	roleName nvarchar(50),
	[status] bit
)

GO

CREATE TABLE tblUsers(
	userID     char(100) PRIMARY KEY,
	fullName   nvarchar(100),
	[password] varchar(100),
	sex		   bit,
	roleID     nvarchar(10) REFERENCES tblRoles(roleID),
	[address]  nvarchar(150),
	birthday   date,
	phone      varchar(20),
	[status]   bit
)

GO

CREATE TABLE tblOrderStatus(
	statusID int PRIMARY KEY,
	statusName nvarchar(50)
)
-----tblOrderStatus(statusID, statusName)---------
GO

CREATE TABLE tblOrder(
	orderID   int identity(1,1) PRIMARY KEY,
	orderDate date,
	total     int,
	userID    char(100) REFERENCES tblUsers(userID),
payType nvarchar(50),
	trackingID varchar(40),
	fullName nvarchar(100),
	[address] nvarchar(150),
	phone varchar(20),
	email char(100),
	note nvarchar(200),
	transactionNumber varchar(100)
)
---tblOrder(orderID{identity}, orderDate, total, userID, payType, trackingID, fullName, [address], phone, email, note, transactionNumber)-------
GO

GO

CREATE TABLE tblOrderStatusUpdate(
	ID int identity(1,1) PRIMARY KEY,
	statusID int REFERENCES tblOrderStatus(statusID),
	orderID int REFERENCES tblOrder(orderID),
	updateDate smalldatetime,
	modifiedBy char(100),
roleID nvarchar(50) 
)
----tblOrderStatusUpdate(ID{identity}, statusID, orderID, updateDate, modifiedBy, role)----

CREATE TABLE tblCategory(
	categoryID   int identity(1,1) PRIMARY KEY,
	categoryName nvarchar(50),
	[order] int,
	[status]	 bit
)

GO

CREATE TABLE tblProduct(
	productID       		int identity(1,1) PRIMARY KEY,
	productName		nvarchar(50),
	[description]		nvarchar(500),
	price			int,
	categoryID		int REFERENCES tblCategory(categoryID),
	discount		int,
	lowStockLimit 		int, 
	[status]			bit
)
----tblProduct(productID{identity}, productName, [description], price, categoryID, discount, lowStockLimit, [status])--------

GO

CREATE TABLE tblProductColors(
	productColorID int identity(1,1) PRIMARY KEY,
	productID int REFERENCES tblProduct(productID),
color nvarchar(50)
)
--tblProductColors(productColorID  [identity] , productID , color )----
GO

CREATE TABLE tblColorImage(
	colorImageID int identity(1,1) PRIMARY KEY,
	productColorID int REFERENCES tblProductColors(productColorID),
	[image] nvarchar(250)
)
	--tblColorImage(colorImageID   [identity] , productColorID , [image])----

CREATE TABLE tblColorSizes(
	colorSizeID int identity(1,1) PRIMARY KEY,
	productColorID int REFERENCES tblProductColors(productColorID),
	size	varchar(50),
	quantity int
)

--tblColorSizes(colorSizeID , productColorID, size, quantity)----
GO

CREATE TABLE tblRating(
	id	int identity(1,1) PRIMARY KEY,
	productID	int REFERENCES tblProduct(productID),	
	userID 		char(100) REFERENCES tblUsers(userID),
orderID	int REFERENCES tblOrder(orderID),
	content	nvarchar(500),
	star		int,
	rateDate	date
)
---tblRating(id [identity], productID, userID ,orderID , content, star, rateDate)----

GO

CREATE TABLE tblOrderDetail(
	detailID  	int identity(1,1) PRIMARY KEY,
	price     	int,
	quantity  	int,
	size		varchar(50),
	color		nvarchar(50),
	orderID   	int REFERENCES tblOrder(orderID),
	productID 	int REFERENCES tblProduct(productID),
)
GO
---tblOrderDetail(detailID la tu tang, price, quantity, size, color, orderID, productID)----

CREATE TABLE tblCart(
	id	int identity(1,1) PRIMARY KEY,
	userID char(100) REFERENCES tblUsers(userID),
	fullName   nvarchar(100),
	[address]  nvarchar(150),
	phone      varchar(20),
email	char(100),
note nvarchar(200),
payType 	nvarchar(50),
CONSTRAINT fk_shopping_user
        FOREIGN KEY (userID)
        REFERENCES tblUsers(userID)
        ON DELETE SET NULL
        ON UPDATE SET NULL

)

GO

CREATE TABLE tblCartItems(
	id	int identity(1,1) PRIMARY KEY,
	productID	int REFERENCES tblProduct(productID),
	sessionID 	int REFERENCES tblCart(id),
	quantity	int,
	size	varchar(50),
	color	nvarchar(50)
)

GO

ALTER TABLE tblCartItems
ADD CONSTRAINT fk_session
        FOREIGN KEY (sessionID)
        REFERENCES tblCart(id)
        ON DELETE SET NULL
        ON UPDATE SET NULL

GO

CREATE TABLE tblReturns(
	id int identity(1,1) PRIMARY KEY,
	detailID int REFERENCES tblOrderDetail(detailID),
	quantity int,
	returnType nvarchar(50),
	returnDate date,
	note nvarchar(100)
)

---tblReturns(id [identity], detailID , quantity, returnType, returnDate, note)----

INSERT INTO tblRoles VALUES
('AD', 'Admin', 1),
('CM', 'Customer', 1),
('MN', 'Manager', 1),
('EM', 'Employee', 1)

GO

INSERT INTO tblUsers VALUES
('ellena_admin@gmail.com', N'Phạm Trung Nguyên', '12345', 1, 'AD', N'Vinhome Nguyễn Xiển, Quận 9, TP.HCM', '1992/01/09', '0922882738', 1),
('khanhtran@gmail.com', N'Trần Thị Vân Khánh', '12345', 0, 'MN', N'30 Trần Phú, Đông Hà, Quảng Trị', '2002/12/16', '0945167243', 1),
('giaman@gmail.com', N'Hồ Gia Mẫn', '12345', 0, 'MN', N'73 Nguyễn Xiển, Quận 9, TP.HCM', '2002/12/17', '0973472223', 1),
('lamduy@gmail.com', N'Lê Vũ Lâm Duy', 'duy12345', 1, 'MN', N'89/112,\ Đỗ Xuân Hợp, Quận 9, TP.HCM', '2002/05/10', '093672627', 1),
('trungtong@gmail.com', N'Tống Đức Trung', 'trung123', 1, 'MN', N'85 Yên Đỗ, Quận Bình Thạnh, TP.HCM', '2002/05/04', '093672627', 1),
('matthews121@gmail.com', 'Matthews Samuel', 'matt123', 1, 'EM', N'232 Trần Phú, Quận 2, TP.HCM', '1992/01/09', '122-334-222', 1),
('martin1221@gmail.com', 'Martin Thompson', 'martin69', 1, 'CM', N'100 Harriet Blv., Wisconsin', '1982/01/09', '0124353566', 1),
('kobi@gmail.com', 'Lee Jung Jae', 'ljj123', 1, 'EM', N'23 Lê Lợi, Hóc Môn, TP.HCM', '1991/02/04', '090229339', 1),
('harrypotter12@gmail.com', 'Harry Potter', '123321', 1, 'CM', N'18 Hùng Vương, Quận 1, TP.HCM', '1992/11/09', '019283882', 1),
('monicaluv@gmail.com', 'Monica Risa', 'monica1609', 0, 'CM', N'989 Trần Đại Nghĩa, Thủ Đức, TP.HCM', '2009/10/09', '0922145666', 1),
('godrick888@gmail.com', 'Godrick Min', 'thelord', 1,'CM', N'991 La Thành, Quận Ba Đình, Hà Nội', '1988/12/10', '0822947382', 1),
('maitran21@gmail.com', 'Mai Tran', 'mai123', 0, 'CM', N'90 Lê Văn Việt, Quận 9, TP.HCM', '2005/12/10', '0947436728', 1),
('haunguyen@gmail.com', N'Nguyễn Văn Hậu', 'haunguyen', 1, 'CM', N'12 Huỳnh Thúc Kháng, Quận 1, TP.HCM', '2003/05/10', '0938338835', 1),
('hanguyenanh@gmail.com', 'Nguyen Anh Ha', 'ha1999', 0, 'CM', N'48 Võ Văn Ngân, Thủ Đức, TP.HCM', '2003/05/10', '0938338835', 1),
('haanhtuan@gmail.com', 'Ha Anh Tuan', 'tuan1357', 0, 'EM', N'125/63B Võ Văn Ngân, Thủ Đức, TP.HCM', '1995/05/10', '0938338835', 1)

	
---tblUsers(userID, fullName, [password], sex, roleID, [address], birthday, phone, [status])---

GO

INSERT INTO tblOrderStatus VALUES
(1, N'Chưa xác nhận'),
(2, N'Đã xác nhận'),
(3, N'Đang giao'),
(4, N'Đã giao'),
(5, N'Đã hủy'),
(6, N'Chờ hoàn tiền'),
(7, N'Đã hoàn tiền'),
(8, N'Đã đổi/trả')

--tblOrderStatus(statusID,statusName)-------

GO

INSERT INTO tblOrder VALUES 
('2022/07/02', 1129000, 'harrypotter12@gmail.com', 'VNPay', 'SSLVN4454497778797641810', N'Harry Potter', N'18 Hùng Vương, Quận 1, TP.HCM', '019283882',  'harrypotter12@gmail.com', N'Giao giờ hành chính', 13780588),
('2022/07/04', 605000, 'monicaluv@gmail.com', 'COD', 'SSLVN37480191943152553458', 'Monica Risa', N'989 Trần Đại Nghĩa, Thủ Đức, TP.HCM', '0922145666', 'monicaluv@gmail.com', null, null),
('2022/07/05', 185000, 'hanguyenanh@gmail.com', 'COD', 'SSLVN36160885032451795902', 'Lee Jung Jae', N'23 Lê Lợi, Hóc Môn, TP.HCM', '090229339', 'hanguyenanh@gmail.com', null, null),
('2022/07/06', 370000, 'monicaluv@gmail.com', 'COD', 'SSLVN80743025514474155713', 'Monica Risa', N'989 Trần Đại Nghĩa, Thủ Đức, TP.HCM', '0922145666', 'monicaluv@gmail.com', null, null),
('2022/07/07', 1289000, 'martin1221@gmail.com', 'COD', 'SSLVN11371807270314380917', 'Martin Thompson', N'100 Harriet Blv., Wisconsin', '0124353566', 'martin1221@gmail.com', null, null),
('2022/07/23', 738000, 'maitran21@gmail.com', 'COD', 'SSLVN21085947711528507560', 'Mai Tran', N'90 Lê Văn Việt, Quận 9, TP.HCM', '0947436728', 'maitran21@gmail.com', null, null),
('2022/07/23', 888000, 'haunguyen@gmail.com', 'VNPay', 'SSLVN11187708803131808013', N'Nguyễn Văn Hậu', N'12 Huỳnh Thúc Kháng, Quận 1, TP.HCM', '0938338835', 'haunguyen@gmail.com', null, 16597833),
('2022/07/21', 268000, 'godrick888@gmail.com', 'COD', 'SSLVN54103113879066105821', 'godrick Min', N'991 La Thành, Quận Ba Đình, Hà Nội', '0822947382', 'godrick888@gmail.com', null, null),
('2022/07/20', 228000, 'maitran21@gmail.com', 'COD', 'SSLVN11341725634716085101',  'Mai Tran', N'90 Lê Văn Việt, Quận 9, TP.HCM', '0947436728', 'maitran21@gmail.com', null, null),
('2022/07/22', 536000, 'godrick888@gmail.com', 'VNPay', 'SSLVN37490191625152553458', 'godrick Min', N'991 La Thành, Quận Ba Đình, Hà Nội', '0822947382', 'godrick888@gmail.com', null, 15961254),
('2022/07/04', 1765000, 'hanguyenanh@gmail.com', 'COD', 'SSLVN76091081515898125245', 'Nguyen Anh Ha', N'48 Võ Văn Ngân, Thủ Đức, TP.HCM', '0938338835',  'hanguyenanh@gmail.com', null, null),
('2022/07/06', 1926000, 'maitran21@gmail.com', 'COD', 'SSLVN76091081721838125245', 'Mai Tran', N'90 Lê Văn Việt, Quận 9, TP.HCM', '0947436728', 'maitran21@gmail.com', null, null),
('2022/07/07', 868000, 'haunguyen@gmail.com', 'COD', 'SSLVN87237126686276585086', N'Nguyễn Văn Hậu', N'12 Huỳnh Thúc Kháng, Quận 1, TP.HCM', '0938338835', 'haunguyen@gmail.com', null, null),
('2022/07/10', 453000, 'godrick888@gmail.com', 'COD', 'SSLVN81526126686276585086', 'godrick Min', N'991 La Thành, Quận Ba Đình, Hà Nội', '0822947382', 'godrick888@gmail.com', null, null),
('2022/07/12', 720000, 'maitran21@gmail.com', 'COD', 'SSLVN61405555828311583407', 'Mai Tran', N'90 Lê Văn Việt, Quận 9, TP.HCM', '0947436728', 'maitran21@gmail.com', null, null),
('2022/07/15', 925000, 'godrick888@gmail.com', 'COD', 'SSLVN32401242828311583407', 'godrick Min', N'991 La Thành, Quận Ba Đình, Hà Nội', '0822947382', 'godrick888@gmail.com', null, null),
('2022/07/17', 1513000, 'hanguyenanh@gmail.com', 'COD', 'SSLVN38070795908852759427', 'Nguyen Anh Ha', N'48 Võ Văn Ngân, Thủ Đức, TP.HCM', '0938338835',  'hanguyenanh@gmail.com', null, null),
('2022/07/12', 529000, 'maitran21@gmail.com', 'COD', 'SSLVN97480191943152553458', 'Mai Tran', N'90 Lê Văn Việt, Quận 9, TP.HCM', '0947436728', 'maitran21@gmail.com', null, null),
('2022/07/20', 1420000, 'haunguyen@gmail.com', 'COD', 'SSLVN66561052929520581017', N'Nguyễn Văn Hậu', N'12 Huỳnh Thúc Kháng, Quận 1, TP.HCM', '0938338835', 'haunguyen@gmail.com', null, null),
('2022/07/21', 123000, 'godrick888@gmail.com', 'MoMo', 'SSLVN51811923132770990465','godrick Min', N'991 La Thành, Quận Ba Đình, Hà Nội', '0822947382', 'godrick888@gmail.com', null, 14619005),
('2022/07/07', 370000, 'maitran21@gmail.com', 'COD', 'SSLVN55011923132770990465', 'Mai Tran', N'90 Lê Văn Việt, Quận 9, TP.HCM', '0947436728', 'maitran21@gmail.com', null, null),
('2022/07/08', 952000, 'godrick888@gmail.com', 'COD', 'SSLVN27991671134443514734', 'godrick Min', N'991 La Thành, Quận Ba Đình, Hà Nội', '0822947382', 'godrick888@gmail.com', null, null),
('2022/07/09', 380000, 'hanguyenanh@gmail.com', 'VNPay', 'SSLVN21426471134443514734', 'Nguyen Anh Ha', N'48 Võ Văn Ngân, Thủ Đức, TP.HCM', '0938338835',  'hanguyenanh@gmail.com', null, 13619425),
('2022/07/02', 350000, 'harrypotter12@gmail.com', 'COD', 'SSLVN4454497778791641810',  N'Harry Potter', N'18 Hùng Vương, Quận 1, TP.HCM', '019283882',  'harrypotter12@gmail.com', 'Giao giờ hành chính', null),
('2022/07/03', 256000, 'monicaluv@gmail.com', 'COD', 'SSLVN37480191943152653458', 'Monica Risa', N'989 Trần Đại Nghĩa, Thủ Đức, TP.HCM', '0922145666', 'monicaluv@gmail.com', null, null),
('2022/07/03', 1560000, 'kobi@gmail.com', 'COD', 'SSLVN36160885032451795952', 'Lee Jung Jae', N'23 Lê Lợi, Hóc Môn, TP.HCM', '090229339', 'hanguyenanh@gmail.com', null, null),
('2022/07/03', 1167000, 'monicaluv@gmail.com', 'COD', 'SSLVN80743025514477155713', 'Monica Risa', N'989 Trần Đại Nghĩa, Thủ Đức, TP.HCM', '0922145666', 'monicaluv@gmail.com', null, null),
('2022/07/03', 288000, 'martin1221@gmail.com', 'COD', 'SSLVN11371807270384380917', 'Martin Thompson', N'100 Harriet Blv., Wisconsin', '0124353566', 'martin1221@gmail.com', null, null),
('2022/07/23', 330000, 'maitran21@gmail.com', 'COD', 'SSLVN21085947711520507560', 'Mai Tran', N'90 Lê Văn Việt, Quận 9, TP.HCM', '0947436728', 'maitran21@gmail.com', null, null),
('2022/07/23', 660000, 'haunguyen@gmail.com', 'COD', 'SSLVN11187708803141808013', N'Nguyễn Văn Hậu', N'12 Huỳnh Thúc Kháng, Quận 1, TP.HCM', '0938338835', 'haunguyen@gmail.com', null, null),
('2022/07/21', 952000, 'godrick888@gmail.com', 'COD', 'SSLVN54103113879076105821', 'godrick Min', N'991 La Thành, Quận Ba Đình, Hà Nội', '0822947382', 'godrick888@gmail.com', null, null),
('2022/07/20', 371000, 'maitran21@gmail.com', 'COD', 'SSLVN11341725634719085101', 'Mai Tran', N'90 Lê Văn Việt, Quận 9, TP.HCM', '0947436728', 'maitran21@gmail.com', null, null),
('2022/07/22', 442000, 'godrick888@gmail.com', 'COD', 'SSLVN3749019162512553458', 'godrick Min', N'991 La Thành, Quận Ba Đình, Hà Nội', '0822947382', 'godrick888@gmail.com', null, null),
('2022/07/04', 183000, 'hanguyenanh@gmail.com', 'VNPay', 'SSLVN76091081545898125245', 'Nguyen Anh Ha', N'48 Võ Văn Ngân, Thủ Đức, TP.HCM', '0938338835',  'hanguyenanh@gmail.com', null, 13619005),
('2022/07/06', 185000, 'maitran21@gmail.com', 'COD', 'SSLVN76091081721838125245', 'Mai Tran', N'90 Lê Văn Việt, Quận 9, TP.HCM', '0947436728', 'maitran21@gmail.com', null, null),
('2022/07/07', 888000, 'haunguyen@gmail.com', 'COD', 'SSLVN87237126686476585086', N'Nguyễn Văn Hậu', N'12 Huỳnh Thúc Kháng, Quận 1, TP.HCM', '0938338835', 'haunguyen@gmail.com', null, null),
('2022/07/10', 300000, 'godrick888@gmail.com', 'COD', 'SSLVN81526126686576585086', 'godrick Min', N'991 La Thành, Quận Ba Đình, Hà Nội', '0822947382', 'godrick888@gmail.com', null, null),
('2022/07/12', 366000, 'maitran21@gmail.com', 'COD', 'SSLVN61405555828361583407', 'Mai Tran', N'90 Lê Văn Việt, Quận 9, TP.HCM', '0947436728', 'maitran21@gmail.com', null, null),
('2022/07/15', 183000, 'godrick888@gmail.com', 'COD', 'SSLVN32401242828711583407', 'godrick Min', N'991 La Thành, Quận Ba Đình, Hà Nội', '0822947382', 'godrick888@gmail.com', null, null),
('2022/07/17', 210000, 'hanguyenanh@gmail.com', 'COD', 'SSLVN38070795988852759427', 'Nguyen Anh Ha', N'48 Võ Văn Ngân, Thủ Đức, TP.HCM', '0938338835',  'hanguyenanh@gmail.com', null, null),
('2022/07/12', 123000, 'maitran21@gmail.com', 'COD', 'SSLVN97480191943192553458', 'Mai Tran', N'90 Lê Văn Việt, Quận 9, TP.HCM', '0947436728', 'maitran21@gmail.com', null, null),
('2022/07/20', 123000, 'haunguyen@gmail.com', 'COD', 'SSLVN66561052929020581017', N'Nguyễn Văn Hậu', N'12 Huỳnh Thúc Kháng, Quận 1, TP.HCM', '0938338835', 'haunguyen@gmail.com', null, null),
('2022/07/21', 750000, 'godrick888@gmail.com', 'COD', 'SSLVN51811923139770990465', 'godrick Min', N'991 La Thành, Quận Ba Đình, Hà Nội', '0822947382', 'godrick888@gmail.com', null, null),
('2022/07/07', 380000, 'maitran21@gmail.com', 'VNPay', 'SSLVN55011923132070990465', 'Mai Tran', N'90 Lê Văn Việt, Quận 9, TP.HCM', '0947436728', 'maitran21@gmail.com', null, 13456728),
('2022/07/08', 185000, 'godrick888@gmail.com', 'COD', 'SSLVN27991671133443514734', 'godrick Min', N'991 La Thành, Quận Ba Đình, Hà Nội', '0822947382', 'godrick888@gmail.com', null, null),
('2022/07/09', 857000, 'hanguyenanh@gmail.com', 'COD', 'SSLVN21426471133443514734', 'Nguyen Anh Ha', N'48 Võ Văn Ngân, Thủ Đức, TP.HCM', '0938338835',  'hanguyenanh@gmail.com', null, null),
('2022/07/02', 442000, 'harrypotter12@gmail.com', 'COD', 'SSLVN4454437778791641810',  N'Harry Potter', N'18 Hùng Vương, Quận 1, TP.HCM', '019283882',  'harrypotter12@gmail.com', 'Giao giờ hành chính', null),
('2022/07/03', 2160000, 'monicaluv@gmail.com', 'VNPay', 'SSLVN37480196943152653458', 'Monica Risa', N'989 Trần Đại Nghĩa, Thủ Đức, TP.HCM', '0922145666', 'monicaluv@gmail.com', null, 12393939),
('2022/08/03', 520000, 'hanguyenanh@gmail.com', 'COD', 'SSLVN36160885032458795952', 'Lee Jung Jae', N'23 Lê Lợi, Hóc Môn, TP.HCM', '090229339', 'hanguyenanh@gmail.com', null, null),
('2022/09/03', 1113000, 'monicaluv@gmail.com', 'COD', 'SSLVN80743025114477155713', 'Monica Risa', N'989 Trần Đại Nghĩa, Thủ Đức, TP.HCM', '0922145666', 'monicaluv@gmail.com', null, null),
('2022/07/03', 532000, 'martin1221@gmail.com', 'COD', 'SSLVN11371805270384380917', 'Martin Thompson', N'100 Harriet Blv., Wisconsin', '0124353566', 'martin1221@gmail.com', null, null),
('2022/07/23', 460000, 'maitran21@gmail.com', 'COD', 'SSLVN21085947811520507560', 'Mai Tran', N'90 Lê Văn Việt, Quận 9, TP.HCM', '0947436728', 'maitran21@gmail.com', null, null),
('2022/08/23', 778000, 'haunguyen@gmail.com', 'COD', 'SSLVN11187404803141808013', N'Nguyễn Văn Hậu', N'12 Huỳnh Thúc Kháng, Quận 1, TP.HCM', '0938338835', 'haunguyen@gmail.com', null, null),
('2022/09/21', 532000, 'godrick888@gmail.com', 'VNPay', 'SSLVN54103516879076105821', 'godrick Min', N'991 La Thành, Quận Ba Đình, Hà Nội', '0822947382', 'godrick888@gmail.com', null, 13449595),
('2022/01/20', 495000, 'maitran21@gmail.com', 'COD', 'SSLVN11341765614719085101', 'Mai Tran', N'90 Lê Văn Việt, Quận 9, TP.HCM', '0947436728', 'maitran21@gmail.com', null, null),
('2022/07/22', 520000, 'godrick888@gmail.com', 'COD', 'SSLVN3749018112512553458', 'godrick Min', N'991 La Thành, Quận Ba Đình, Hà Nội', '0822947382', 'godrick888@gmail.com', null, null),
('2022/07/04', 183000, 'hanguyenanh@gmail.com', 'COD', 'SSLVN76061081545898125245', 'Nguyen Anh Ha', N'48 Võ Văn Ngân, Thủ Đức, TP.HCM', '0938338835',  'hanguyenanh@gmail.com', null, null),
('2022/11/06', 185000, 'maitran21@gmail.com', 'COD', 'SSLVN76091081721838125245', 'Mai Tran', N'90 Lê Văn Việt, Quận 9, TP.HCM', '0947436728', 'maitran21@gmail.com', null, null),
('2022/10/07', 888000, 'haunguyen@gmail.com', 'COD', 'SSLVN87237156686476585086', N'Nguyễn Văn Hậu', N'12 Huỳnh Thúc Kháng, Quận 1, TP.HCM', '0938338835', 'haunguyen@gmail.com', null,  null),
('2022-07-21', 3130000, N'monicaluv@gmail.com', N'VNPay', NULL, N'Monica Risa', N'989 Trần Đại Nghĩa, Quận Bình Thạnh, Thành phố Hồ Chí Minh', N'687-343-787', N'monicaluv@gmail.com', N'Giao hàng sớm nha!', N'13801993'),
('2022-07-21', 2136000, N'haunguyen@gmail.com', N'COD', NULL, N'Tống Đức Trung', N'123/45/6 Nguyễn Văn A, Quận Bình Thạnh, Thành phố Hồ Chí Minh', N'0912345678', N'haunguyen@gmail.com', N'', NULL),
('2022-07-21', 2800000, N'monicaluv@gmail.com', N'VNPay', N'JHG329849', N'Monica Risa', N'989 Trần Đại Nghĩa, Quận Bình Thạnh, Thành phố Hồ Chí Minh', N'687-343-787', N'monicaluv@gmail.com', N'Giao hàng sớm nha!', NULL),
('2022-07-21', 2408000, N'godrick888@gmail.com', N'COD', NULL, N'godrick Min', N'991 La Thành, Huyện Kim Bảng, Hà Nam', N'0822947382', N'godrick888@gmail.com', N'', NULL),
('2022-07-21', 2175000, N'hanguyenanh@gmail.com', N'VNPay', NULL, N'Nguyen Anh Ha', N'48 Võ Văn Ngân, Huyện Nậm Pồ, Điện Biên', N'0938338835', N'hanguyenanh@gmail.com', N'', N'13801998'),
('2022-07-21', 300000, N'haunguyen@gmail.com ', N'COD', NULL, N'Tống Đức Trung', N'123/45/6 Nguyễn Văn A, Huyện Nậm Pồ, Điện Biên', N'0912345678', N'haunguyen@gmail.com', N'', NULL)



---tblOrder(orderID{identity}, orderDate, total, userID, payType, trackingID, fullName, [address], phone, email, note, transactionNumber)-------

GO

INSERT INTO tblCategory
VALUES
(N'Áo khoác', 1, 1),
(N'Quần short', 2, 1),
(N'Áo sơ mi', 3, 1),
(N'Quần dài', 4, 1),
(N'Áo thun', 5, 1),
(N'Váy đầm', 6, 1),
(N'Áo vest', 7, 1),
(N'Chân váy', 8, 1)
---tblCategory(categoryID, categoryName, order, [status])--------

GO

INSERT INTO tblProduct
VALUES 
(N'ÁO THUN TAY NGẮN CỔ V', N'Form dáng basic, hiện đại dễ kết hợp với các item khác nhau hòa nhịp với xu hướng thời trang Hàn Quốc.',  216000, 5, 33000, 10, 1),
(N'QUẦN JEANS SKINNY', N'Chiếc quần được thiết kế ôm vừa vặn, phom quần lửng, dáng quần được nghiên cứu hiện đại, thoải mái từ phần hông cho tới phần cẳng chân, giúp tôn đôi chân thon dài của khách hàng.', 424000, 4, 128000, 10, 1),
(N'ĐẦM TAY NGẮN KHOÉT EO', N'Là chiếc đầm bằng vải voan nhẹ nhàng, tay áo lựng có độ phồng nhẹ. Thiết kế trang trí nơ trước ngực, tăng thêm nét dịu dàng cho bạn nữ. Là một chiếc đầm phù hợp cho bạn diện ở nhiều trường hợp khác nhau như đi làm, đi chơi, dạo phố,…', 389000, 6, 0, 10, 1),
(N'ÁO KIỂU TAY DÀI NHÚN THUN VAI', N'Chiếc áo kiểu này là một nét đẹp nữ tính cho các bạn nữ  yêu thích sự nhẹ nhàng. Với chất vải mềm mại kết hợp cùng thiết kế tay áo rộng.', 299000, 3, 89000, 10, 1),
(N'ÁO KHOÁC DENIM NỮ CORDUROY TÚI ĐẮP.', N'Áo khoác denim cổ ve lật, dài tay, cổ tay bo và cài khuy. Có hai túi có nắp trước ngực và túi may viền hai bên hông. Vải hiệu ứng bạc màu. Cài khuy phía trước.', 460000, 1, 0, 10, 1),
(N'QUẦN KAKI CARROT', N'Form quần carrot vừa xuất hiện đã thu hút giới trẻ bởi phong cách năng động và hiện đại, dễ dàng mix-match và làm mới phong cách của riêng bạn.',  320000, 4, 32000, 10,1),
(N'ÁO DỆT KIM TAY NGẮN', N'Chất liệu dệt kim đem lại form cảm giác thoải mái khi mặc. Kích thước phù hợp cho các bạn nữ <55kg, form xuông mặc rất cá tính, thoải mái và dễ phối đồ. Sản phẩm có thể phối với chân váy hoặc quần cạp cao sẽ trở thành nột set đồ lí tưởng cho chị em.', 495000, 3, 124000, 10,1),
(N'QUẦN SHORT TÚI XÉO 2 NÚT', N'Quần được thiết kế với hình dáng khỏe khoắn, mang lại cho các bạn nữ một ngoại hình sảng khoái và phá cách.', 520000, 2, 78000, 10,1),
(N'ĐẦM CARO RÚT NGỰC', N'Đầm caro rút ngực tay phồng với tay phồng nhún nhẹ nhàng. Điểm nhấn phá cách bằng dây rút tạo nhún ngay ngực, sexy mà vẫn không hở hang.', 520000, 6, 0, 10,1),
(N'ÁO THUN TAY NGẮN THÊU CHỮ', N'Đối với các cô gái, áo thun được ưa chuộng nhờ sự đa năng, linh hoạt khi phối đồ từ đó tạo ra nhiều phong cách ăn mặc khác nhau. ', 185000, 5, 0, 10,1),
(N'ÁO KHOÁC JEANS CƠ BẢN', N'Áo khoác jeans form cơ bản, có nút ở giữa, áo wash rách ở ngực bên trái, tạo kiểu, áo rã đô, có 2 túi 2 bên ngực, có túi mổ bên hông, áo wash rách thân sau tạo kiểu.', 595000, 1, 119000, 10, 17),
(N'ĐẦM SUÔNG BUỘC EO', N'Đầm form suông, bâu danton, tay ngắn, xếp ly nhún ở cửa tay, viền cửa tay khoảng 1cm, thân sau có xẻ tà, đần kèm dây thắt đai eo, không dây kéo.', 495000, 6, 149000, 10, 1),
(N'ĐẦM SƠ MI PHỐI BÈO', N'Đầm form A nhẹ, cổ tròn, không tay, phối bèo tạo kiểu, giữa đầm có nút giả, dây kéo phía sau, cổ sau có khuy nút tháo mở được.', 285000, 6, 29000, 10,1),
(N'VÁY RÚT DÂY', N'Chiếc váy mang đậm phong cách nữ tính, dễ thương và duyên dáng, được rất nhiều chị em yêu thích bởi sự đơn giản và tạo sự thoải mái khi diện bộ trang phục này. Với tạng người dù cao, thấp hay ốm đều có thể tự tin khi diện.', 285000, 8, 57000, 10, 1),
(N'ÁO KHOÁC JEANS PHỐI TÚI', N'Áo khoác jeans form croptop, có nút ở giữa, tay dài phối măng sết, bản măng sết khoảng 4cm có nút cài, áo rã đô, rã cách điệu tạo kiểu, ở trước 2 bên ngực có túi hộp, phần lai áo tua rua tạo kiểu.', 312000, 1, 44000, 10, 1),
(N'ÁO VEST BLAZER', N'Áo vest blazer, tay dài, cửa tay có xẻ khoảng 11cm, có 3 nút trang trí, phía trước có mổ túi giả, phía sau có xẻ khoảng 18cm.', 665000, 7, 133000, 10, 1),
(N'VÁY BÚT CHÌ TÚI ĐẮP', N'Chân váy bút chì, lưng liền, phía trước có 2 túi đắp, trên túi có nút nhựa, đây kéo phía sau, xẻ tà đắp khoảng 21cm', 265000, 8, 22000, 5, 1),
(N'ÁO CỔ TIM SỌC NGANG', N'Áo thun form ôm, cổ tim, tay ngắn, siêu đáng yêu.', 145000, 5, 22000, 5, 1),
(N'ÁO SƠ MI GIẤU NÚT', N'Áo sơ mi form cơ bản, tay dài, bản măng sết khoảng 3.5cm, phần nẹp áo là nẹp che giấu nút, thân sau có xếp ly', 300000, 3, 15000, 10, 1),
(N'ÁO THẮT NƠ TAY PHỒNG', N'Áo sơ mi chui đầu, cổ tim, cổ có dây nơ tạo kiểu, tay dài, có măng sết khoảng 6cm, có 2 nút nhựa cài.', 300000, 3, 0, 10, 1),
(N'QUẦN TÂY SUÔNG TÚI NẸP', N'Quần tây form suông, bản lưng khoảng 3.5cm, quần có paget, dây kéo ở giữa, có móc cài, có túi sườn, đính nút tạo kiểu ở 2 bên túi, thân sau có miệng túi giả bên phải.', 350000, 4, 0, 10, 1),
(N'QUẦN JEANS ỐNG LOE', N'Quần jeans ống hơi loe, bản lưng khoảng cm, quần có paget, dây kéo ở giữa, có nút, phần lai tua rua.', 400000, 4, 20000, 10, 1),
(N'QUẦN TÂY CƠ BẢN', N'Quần tây cơ bản, bản lưng khoảng 4cm, quần có paghet, dây kéo ở giữa, có nút, có túi.', 350000, 4, 0, 10, 1),
(N'QUẦN ỐNG ĐỨNG 2 NÚT', N'Quần tây cơ bản, bản lưng khoảng 4.7cm, có paghet, dây kéo ở giữa, có 2 nút, có móc cài, quần có túi 2 bên sườn.', 350000, 4, 50000, 10, 1),
(N'ÁO KHOÁC DÙ RÚT DÂY', N'Quần tây form suông, bản lưng khoảng 3.5cm, quần có paget, dây kéo ở giữa, có móc cài, có túi sườn, đính nút tạo kiểu ở 2 bên túi, thân sau có miệng túi giả bên phải.', 450000, 1, 120000, 10, 1)

----tblProduct(productID{identity}, productName, [description], price, categoryID, discount, lowStockLimit, [status])--------

GO

INSERT INTO tblProductColors
VALUES 
(1, N'Trắng'),
(1, N'Đen'),
(2, N'Trắng'),
(2, N'Nâu'),
(3, N'Trắng'),
(3, N'Xanh nhạt'),
(4, N'Đỏ'),
(4, N'Nâu'),
(5, N'Xanh rêu'),
(6,  N'Kem'),
(6, N'Bò'),
(7, N'Xám'),
(7, N'Be'),
(8, N'Be'),
(9, N'Be'),
(10, N'Đen'),
(10, N'Be'),
(11, N'Trắng'),
(11, N'Đen'),
(11, N'Xanh'),
(12, N'Xanh đen'),
(13, N'Trắng'),
(14, N'Đen'),
(15, N'Xanh'),
(15, N'Xanh nhạt'),
(16, N'Đen'),
(17, N'Đen'),
(18, N'Be'),
(18, N'Hồng'),
(19, N'Trắng'),
(20, N'Hồng'),
(20, N'Xanh'),
(21, N'Đen'),
(21, N'Xám'),
(22, N'Xanh đậm'),
(22, N'Xanh nhạt'),
(23, N'Đen'),
(23, N'Xám'),
(24, N'Xám'),
(25, N'Đen'),
(25, N'Nâu')

--tblProductColors(productColorID [identity] , productID, color, [image])---- NEW*

GO

INSERT INTO tblColorImage
VALUES
(1, '/images/ao-thun-tay-ngan-co-v-trang.jpg'),
(1,  '/images/ao-thun-tay-ngan-co-v-trang-1.jpg'),
(2, '/images/ao-thun-tay-ngan-co-v-den.jpg'),
(3, '/images/quan-jeans-skinny-trang.jpg'),
(4, '/images/quan-jeans-skinny-nau.jpg'),
(5, '/images/dam-tay-ngan-khoet-eo-trang.jpg'),
(6, '/images/dam-tay-ngan-khoet-eo-xanh-nhat.jpg'),
(7, '/images/ao-kieu-tay-dai-nhun-thun-vai-do.jpg'),
(8, '/images/ao-kieu-tay-dai-nhun-thun-vai-nau.jpg'),
(9, '/images/ao-khoac-denim-nu-corduroy-tui-dap-xanh-reu.jpg'),
(9, '/images/ao-khoac-denim-nu-corduroy-tui-dap-xanh-reu-1.jpg'),
(10, '/images/quan-kaki-carrot-kem.jpg'),
(11, '/images/quan-kaki-carrot-bo.jpg'),
(12, '/images/ao-det-kim-tay-ngan-xam.jpg'),
(13, '/images/ao-det-kim-tay-ngan-be.jpg'),
(14, '/images/quan-shorts-tui-xeo-2-nut-be.jpg'),
(15, '/images/dam-caro-rut-nguc-be.jpg'),
(16, '/images/ao-thun-tay-ngan-theu-chu-den.jpg'),
(17, '/images/ao-thun-tay-ngan-theu-chu-be.jpg'),
(18, '/images/ao-khoac-jeans-co-ban-trang.jpg'),
(19, '/images/ao-khoac-jeans-co-ban-den.jpg'),
(20, '/images/ao-khoac-jeans-co-ban-xanh.jpg'),
(21, '/images/dam-suong-buoc-eo-xanh-den.jpg'),
(22, '/images/dam-so-mi-phoi-beo-trang.jpg'),
(23, '/images/vay-rut-day-den.jpg'),
(24, '/images/ao-khoac-jeans-phoi-tui-xanh.jpg'),
(25, '/images/ao-khoac-jeans-phoi-tui-xanh-nhat.jpg'),
(26, '/images/ao-vest-blazer-den.jpg'),
(27, '/images/vay-but-chi-tui-dap-den.jpg'),
(28, '/images/ao-co-tim-soc-ngang-be.jpg'),
(29, '/images/ao-co-tim-soc-ngang-hong.jpg'),
(30, '/images/ao-so-mi-giau-nut-trang.jpg'),
(30, '/images/ao-so-mi-giau-nut-trang-1.jpg'),
(31, '/images/ao-that-no-tay-phong-hong.jpg'),
(32, '/images/ao-that-no-tay-phong-xanh.jpg'),
(33, '/images/quan-tay-suong-tui-nep-den.jpg'),
(34, '/images/quan-tay-suong-tui-nep-xam.jpg'),
(35, '/images/quan-jeans-ong-loe-xanh-dam.jpg'),
(36, '/images/quan-jeans-ong-loe-xanh-nhat.jpg'),
(37, '/images/quan-tay-co-ban-den.jpg'),
(38, '/images/quan-tay-co-ban-xam.jpg'),
(39, '/images/quan-ong-dung-2-nut-xam.jpg'),
(39, '/images/quan-ong-dung-2-nut-xam-1.jpg'),
(40, '/images/ao-khoac-du-rut-day-den.jpg'),
(41, '/images/ao-khoac-du-rut-day-nau.jpg')

GO
--tblColorImage(colorImageID   [identity] , productColorID , [image])----

INSERT INTO tblColorSizes(productColorID, size, quantity) VALUES
(1, 'XS', 30),
(1, 'S', 32),
(2, 'XS', 230),
(2, 'S', 30),
(3, '27', 22),
(3, '28', 154),
(4, '27', 123),
(4, '28', 23),
(5,  'M', 56),
(5, 'L', 70),
(6,  'M', 56),
(6, 'L', 74),
(7, 'M', 93),
(7, 'L', 10),
(8, 'S', 13),
(9, 'S', 39),
(10, 'S', 30),
(10, 'M', 2),
(11, 'S', 102),
(11, 'M', 59),
(11, 'L', 71),
(12, 'M', 45),
(12, 'L', 45),
(13, 'S', 83),
(13, 'M', 83),
(14, 'L', 70),
(15, 'M', 79),
(15, 'L', 34),
(16, 'XS', 23),
(16, 'S', 75),
(16, 'M', 38),
(17, 'L', 20),
(18, 'S', 58),
(18, 'L', 10),
(19, 'L', 15),
(20, 'S', 39),
(20, 'M', 76),
(21, 'L', 38),
(21, 'M', 57),
(22, 'S', 37),
(22, 'M', 4),
(23, 'L', 92),
(23, 'M', 102),
(24, 'S', 73),
(24, 'M', 20),
(25, 'S', 67),
(25, 'M', 49),
(26, 'L', 40),
(26, 'M', 82),
(27, 'S', 58),
(28, 'M', 20),
(28, 'L', 10),
(29, 'M', 50),
(29, 'L', 70),
(30, 'S', 20),
(30, 'M', 24),
(31, 'M', 42),
(31, 'L', 42),
(32, 'M', 92),
(32, 'L', 33),
(32, 'XL', 34),
(33, 'S', 134),
(33, 'M', 84),
(34, 'S', 90),
(34, 'M', 54),
(35, 'S', 28),
(35, 'M', 120),
(35, 'L', 19),
(36, 'S', 30),
(36, 'M', 23),
(36, 'L', 74),
(37, 'L', 100),
(37, 'XL', 90),
(38, 'L', 88),
(38, 'XL', 29),
(39, 'M', 39),
(39, 'L', 64),
(40, 'M', 15),
(40, 'L', 39),
(41, 'M', 77),
(41, 'L', 57)

--tblColorSizes(colorSizeID, productColorID, size, quantity)----

GO

INSERT INTO tblOrderDetail(price, quantity, size, color, orderID, productID)
VALUES
(133000, 2, 'S', N'Trắng', 1, 1),
(183000, 1, 'S', N'Đen', 1, 1),
(210000, 1, 'S', N'Nâu', 1, 4),
(185000, 1, 'M', N'Đen', 1, 10),
(185000, 1, 'L', N'Be', 1, 10),
(185000, 1, 'M', N'Đen', 2, 10),
(210000, 2, 'S', N'Nâu', 2, 4),
(185000, 1, 'L', N'Be', 3, 10),
(185000, 2, 'L', N'Be', 4, 10),
(476000, 1,  'L', N'Đen', 5, 11),
(371000, 1,  'M', N'Be', 5, 7),
(442000, 1,  'L', N'Be', 5, 8),
(183000, 1, 'S', N'Đen', 6, 1),
(185000, 3, 'XS', N'Đen', 6, 10),
(296000, 3, '28', N'Nâu', 7, 2),
(268000, 1, 'S', N'Xanh', 8, 15),
(228000, 1, 'M', N'Đen', 9, 14),
(268000, 2, 'S', N'Xanh nhạt', 10, 15),
(476000, 2,  'L', N'Đen', 11, 11),
(371000, 1,  'M', N'Xám', 11, 7),
(442000, 1,  'L', N'Be', 11, 8),
(183000, 1, 'S', N'Đen', 12, 1),
(285000, 3, 'M', N'Trắng', 12, 19),
(296000, 3, '27', N'Trắng', 12, 2),
(268000, 1, 'M', N'Xanh', 13, 15),
(300000, 2, 'M', N'Hồng', 13, 20),
(243000, 1, 'S', N'Đen', 14, 17),
(210000, 1, 'S', N'Đỏ', 14, 4),
(350000, 1, 'M', N'Xám', 15, 21),
(185000, 1, 'L', N'Be', 15, 10),
(185000, 1, 'M', N'Đen', 15, 10),
(185000, 2, 'XS', N'Đen', 16, 4),
(185000, 1, 'M', N'Đen', 16, 10),
(185000, 2, 'L', N'Be', 16, 10),
(476000, 2,  'M', N'Đen', 17, 11),
(371000, 1,  'S', N'Trắng', 17, 7),
(442000, 1,  'L', N'Be', 17, 8),
(183000, 1, 'XS', N'Đen', 18, 1),
(346000, 3, 'L', N'Xanh đen',18, 12),
(296000, 3, '28', N'Nâu', 19, 2),
(532000, 1, 'M', N'Đen', 19, 16),
(123000, 1, 'M', N'Hồng', 20, 18),
(185000, 2, 'L', N'Be', 21, 10),
(476000, 2,  'S	', N'Xanh', 22, 11),
(380000, 1,  'M', N'Xanh đậm', 23, 22),
(350000, 1,  'L', N'Xám', 24, 23),
(256000, 1, 'M', N'Trắng', 25, 13),
(520000, 3, 'M', N'Be',26, 9),
(389000, 3, 'L', N'Trắng', 27, 3),
(288000, 1, 'S', N'Kem', 28, 6),
(330000, 1, 'L', N'Nâu', 29, 25),
(330000, 2, 'M', N'Đen', 30, 10),
(476000, 2,  'L', N'Đen', 31, 11),
(371000, 1,  'M', N'Be', 32, 7),
(442000, 1,  'L', N'Be', 33, 8),
(183000, 1, 'S', N'Đen', 34, 1),
(185000, 1, 'XS', N'Đen', 35, 10),
(296000, 3, '28', N'Trắng', 36, 2),
(300000, 1, 'L', N'Xám', 37, 24),
(183000, 2, 'S', N'Trắng', 38, 1),
(183000, 1, 'S', N'Đen', 39, 1),
(210000, 1, 'M', N'Đỏ', 40, 4),
(123000, 1, 'M', N'Be', 41, 18),
(123000, 1, 'L', N'Be', 42, 18),
(330000, 1, 'M', N'Nâu', 43, 25),
(210000, 2, 'S', N'Nâu', 43, 4),
(380000, 1, 'M', N'Xanh nhạt', 44, 22),
(185000, 1, 'S', N'Đen', 45, 10),
(243000, 2,  'S', N'Đen', 46, 17),
(371000, 1,  'S', N'Be', 46, 7),
(442000, 1,  'L', N'Be', 47, 8),
(216000, 1, 'S', N'Đen', 48, 1),
(520000, 1, 'M', N'Be',49, 9),
(371000, 3, 'S', N'Be', 50, 7),
(532000, 1, 'M', N'Đen', 51, 16),
(460000, 1, 'S', N'Xanh rêu', 52, 5),
(289000, 2, 'M', N'Xanh nhạt', 53, 3),
(285000, 2,  'M', N'Trắng', 54, 19),
(495000, 1,  'S', N'Be', 55, 7),
(520000, 1,  'L', N'Be', 56, 8),
(183000, 1, 'S', N'Đen', 57, 1),
(185000, 1, 'L', N'Be',58, 10),
(296000, 3, '28', N'Trắng', 59, 2),
(330000, 1, N'L', N'Nâu', 60, 25),
(330000, 4, N'L', N'Đen', 60, 25),
(296000, 2, N'28', N'Nâu', 60, 2),
(296000, 3, N'28', N'Trắng', 60, 2),
(350000, 1, N'XL', N'Xám', 61, 23),
(350000, 0, N'L', N'Đen', 61, 23),
(300000, 1, N'M', N'Hồng', 61, 20),
(330000, 1, N'L', N'Đen', 61, 25),
(228000, 2, N'L', N'Đen', 61, 14),
(350000, 8, N'XL', N'Xám', 62, 23),
(300000, 2, N'L', N'Hồng', 63, 20),
( 296000, 3, N'28', N'Nâu', 63, 2),
(460000, 2, N'S', N'Xanh rêu', 63, 5),
(123000, 4, N'L', N'Hồng', 64, 18),
(123000, 1, N'L', N'Be', 64, 18),
(520000, 3, N'L', N'Be', 64, 9),
(300000, 1, N'L', N'Xám', 65, 24),
(350000, 1, N'XL', N'Đen', 61, 23)

---tblOrderDetail(detailID la tu tang, price, quantity, size, color, orderID, productID)----

GO

INSERT INTO tblRating VALUES
(10, 'hanguyenanh@gmail.com', 23, N'Mặc hợp dáng, vải mát ôm form thích lắm luôn. Cho shop 5 sao <3', 5, '2022/05/04'),
(10, 'hanguyenanh@gmail.com', 11, N'Áo đẹp, lần sau mua lại', 5, '2022/05/04'),
(11, 'hanguyenanh@gmail.com', 11, N'Mua cho con bạn thân. Nó review ok.', 4, '2022/05/04'),
(1, 'hanguyenanh@gmail.com', 34, N'Hàng đi kèm giấy cảm ơn của shop đáng yêu quá đi. Lần sau sẽ ủng hộ tiếp <333', 5, '2022/05/04'),
(1, 'monicaluv@gmail.com', 48, N'Không đẹp như tưởng tượng', 2, '2022/05/04'),
(10, 'monicaluv@gmail.com', 4, N'Hôm qua đặt hôm nay có luôn. Áo đẹp không phàn nàn gì về chất lượng cả.', 5, '2022/05/04'),
(1, 'maitran21@gmail.com', 6, N'Sản phẩm đáng mua, với giá tiền này thì không có gì để chê cả', 5, '2022/05/12'),
(10, 'maitran21@gmail.com', 6, N'Hài lòng về chất liệu và giá thành, giao hàng nhanh', 5, '2022/05/04'),
(7, 'maitran21@gmail.com', 55, N'Vải dày, đường may đẹp, thời gian giao hàng rất nhanh', 4, '2022/05/30'),
(11, 'maitran21@gmail.com', 15, N'Hàng đẹp, vải khá thoáng, hàng giao nhanh sẽ ủng hộ ', 5, '2022/05/18'),
(1, 'maitran21@gmail.com', 38, N'Vải nóng, mặc chỗ nào có điều hòa thôi, ra đường thì chịu', 2, '2022/05/15'),
(10, 'godrick888@gmail.com', 10, N'Đường chỉ bên tay trái bị lỗi khì nó nhăn khá xấu.', 3, '2022/05/17'),
(7, 'martin1221@gmail.com', 5, N'Hàng cotton mặc mát. Giặt cũng không bị nhăn. Hợp cho các bạn đi làm', 5, '2022/05/04'),
(8, 'godrick888@gmail.com', 33, N'Sản phẩm đáng mua, với giá tiền này thì không có gì để chê cả', 5, '2022/05/12'),
(11, 'godrick888@gmail.com', 54, N'Nay buồn nên cho 1 sao nha shop =))', 5, '2022/05/04'),
(8, 'harrypotter12@gmail.com', 47, N'Quần khá ổn, chất vải mỏng nhưng vẫn không lộ, giao hơi lâu, mặc size S 1m47 37kg oke', 4, '2022/05/30'),
(11, 'martin1221@gmail.com', 5, N'Sản phẩm tốt đồ đẹp, y như hình, chất lượng cao, sẽ ủng hộ shop lần sau', 5, '2022/05/18'),
--(9, 'maitran21@gmail.com', N'Mua cho mẹ nhân Ngày của Mẹ. Mẹ khen con gái có mắt nhìn :D', 5, '2022/05/15'),
(8, 'martin1221@gmail.com', 5, N'Đồ xinh lắm. Vải đẹp. Đường may cẩn thận. K chỉ thừa.', 3, '2022/05/17')

---tblRating(id [identity], productID, userID ,orderID , content, star, rateDate)----

GO

INSERT INTO tblOrderStatusUpdate(statusID, orderID, updateDate, modifiedBy, roleID)
VALUES
(1, 1, '2022-07-15 10:28', 'System', ''),
(2, 1, '2022-07-17 16:46', 'kobi@gmail.com', 'EM'),
(3, 1, '2022-07-18 10:58', 'giaman@gmail.com', 'MN'),
(4, 1, '2022-07-20 20:38', 'giaman@gmail.com', 'MN'),
(1, 2, '2022-04-12 14:37', 'System', ''),
(2, 2, '2022-04-14 12:30', 'trungtong@gmail.com','MN'),
(3, 2, '2022-04-15 20:29', 'trungtong@gmail.com','MN'),
(4, 2, '2022-04-16 20:34', 'matthews121@gmail.com','EM'),
(1, 3, '2022-05-11 20:12', 'System', ''),
(2, 3, '2022-05-12 19:28', 'kobi@gmail.com', 'EM'),
(3, 3, '2022-05-13 14:56', 'matthews121@gmail.com','EM'),
(4, 3, '2022-05-15 13:55', 'matthews121@gmail.com','EM'),
(1, 4, '2022-06-12 22:29', 'System', ''),
(2, 4, '2022-06-13 15:50', 'kobi@gmail.com', 'EM'),
(3, 4, '2022-06-14 20:48', 'kobi@gmail.com', 'EM'),
(4, 4, '2022-06-15 15:13', 'giaman@gmail.com', 'MN'),
(1, 5, '2022-07-21 13:27', 'System', ''),
(2, 5, '2022-07-22 12:39', 'matthews121@gmail.com','EM'),
(3, 5, '2022-07-24 19:48', 'matthews121@gmail.com','EM'),
(4, 5, '2022-07-26 13:36', 'haanhtuan@gmail.com', 'EM'),
(1, 6, '2022-05-13 10:18', 'System', ''),
(2, 6, '2022-05-15 22:16', 'matthews121@gmail.com','EM'),
(3, 6, '2022-05-17 12:45', 'giaman@gmail.com', 'MN'),
(4, 6, '2022-05-19 22:24', 'giaman@gmail.com', 'MN'),
(1, 7, '2022-04-14 18:18', 'System', ''),
(2, 7, '2022-04-16 21:27', 'kobi@gmail.com', 'EM'),
(3, 7, '2022-04-17 13:37', 'kobi@gmail.com', 'EM'),
(1, 8, '2022-07-18 14:55', 'System', ''),
(2, 8, '2022-07-19 20:30', 'trungtong@gmail.com','MN'),
(3, 8, '2022-07-20 11:33', 'matthews121@gmail.com','EM'),
(4, 8, '2022-07-21 13:26', 'kobi@gmail.com', 'EM'),
(1, 9, '2022-05-10 11:24', 'System', ''),
(2, 9, '2022-05-11 14:10', 'giaman@gmail.com', 'MN'),
(3, 9, '2022-05-12 19:38', 'matthews121@gmail.com','EM'),
(4, 9, '2022-05-13 17:32', 'haanhtuan@gmail.com', 'EM'),
(1, 10, '2022-07-10 15:48', 'System', ''),
(2, 10, '2022-07-11 19:41', 'haanhtuan@gmail.com', 'EM'),
(3, 10, '2022-07-12 13:41', 'haanhtuan@gmail.com', 'EM'),
(4, 10, '2022-07-13 23:10', 'haanhtuan@gmail.com', 'EM'),
(1, 11, '2022-05-18 16:46', 'System', ''),
(2, 11, '2022-05-20 22:35', 'kobi@gmail.com', 'EM'),
(3, 11, '2022-05-22 11:26', 'trungtong@gmail.com','MN'),
(4, 11, '2022-05-23 23:38', 'kobi@gmail.com', 'EM'),
(1, 12, '2022-04-22 21:32', 'System', ''),
(2, 12, '2022-04-24 11:46', 'trungtong@gmail.com','MN'),
(3, 12, '2022-04-26 18:10', 'giaman@gmail.com', 'MN'),
(4, 12, '2022-04-28 16:19', 'giaman@gmail.com', 'MN'),
(1, 13, '2022-04-20 12:44', 'System', ''),
(2, 13, '2022-04-21 14:54', 'trungtong@gmail.com','MN'),
(3, 13, '2022-04-23 22:48', 'matthews121@gmail.com','EM'),
(1, 14, '2022-06-10 15:47', 'System', ''),
(2, 14, '2022-06-12 19:37', 'haanhtuan@gmail.com', 'EM'),
(3, 14, '2022-06-14 11:54', 'kobi@gmail.com', 'EM'),
(1, 15, '2022-06-17 18:54', 'System', ''),
(2, 15, '2022-06-18 23:52', 'haanhtuan@gmail.com', 'EM'),
(3, 15, '2022-06-19 16:18', 'haanhtuan@gmail.com', 'EM'),
(4, 15, '2022-06-20 23:17', 'kobi@gmail.com', 'EM'),
(1, 16, '2022-05-13 10:16', 'System', ''),
(2, 16, '2022-05-15 20:49', 'trungtong@gmail.com','MN'),
(3, 16, '2022-05-16 10:45', 'trungtong@gmail.com','MN'),
(4, 16, '2022-05-18 13:59', 'matthews121@gmail.com','EM'),
(1, 17, '2022-06-11 19:30', 'System', ''),
(2, 17, '2022-06-13 18:52', 'giaman@gmail.com', 'MN'),
(3, 17, '2022-06-14 15:49', 'trungtong@gmail.com','MN'),
(5, 17, '2022-06-15 13:40', 'matthews121@gmail.com','EM'),
(1, 18, '2022-05-22 10:24', 'System', ''),
(2, 18, '2022-05-24 17:13', 'giaman@gmail.com', 'MN'),
(3, 18, '2022-05-26 16:10', 'matthews121@gmail.com','EM'),
(4, 18, '2022-05-27 21:10', 'matthews121@gmail.com','EM'),
(1, 19, '2022-07-19 15:45', 'System', ''),
(2, 19, '2022-07-20 12:27', 'giaman@gmail.com', 'MN'),
(3, 19, '2022-07-21 15:39', 'kobi@gmail.com', 'EM'),
(4, 19, '2022-07-23 22:32', 'matthews121@gmail.com','EM'),
(1, 20, '2022-06-22 14:17', 'System', ''),
(2, 20, '2022-06-23 17:17', 'giaman@gmail.com', 'MN'),
(3, 20, '2022-06-25 17:40', 'kobi@gmail.com', 'EM'),
(1, 21, '2022-05-11 22:28', 'System', ''),
(2, 21, '2022-05-13 21:24', 'matthews121@gmail.com','EM'),
(3, 21, '2022-05-14 18:33', 'matthews121@gmail.com','EM'),
(4, 21, '2022-05-15 12:40', 'haanhtuan@gmail.com', 'EM'),
(1, 22, '2022-05-18 16:13', 'System', ''),
(2, 22, '2022-05-19 17:32', 'trungtong@gmail.com','MN'),
(3, 22, '2022-05-20 21:43', 'matthews121@gmail.com','EM'),
(4, 22, '2022-05-22 15:24', 'kobi@gmail.com', 'EM'),
(1, 23, '2022-05-11 22:45', 'System', ''),
(2, 23, '2022-05-12 22:46', 'kobi@gmail.com', 'EM'),
(3, 23, '2022-05-14 19:33', 'giaman@gmail.com', 'MN'),
(4, 23, '2022-05-16 21:47', 'kobi@gmail.com', 'EM'),
(1, 24, '2022-06-19 14:30', 'System', ''),
(2, 24, '2022-06-20 12:56', 'kobi@gmail.com', 'EM'),
(3, 24, '2022-06-22 17:43', 'kobi@gmail.com', 'EM'),
(4, 24, '2022-06-24 16:38', 'kobi@gmail.com', 'EM'),
(1, 25, '2022-07-13 18:11', 'System', ''),
(2, 25, '2022-07-15 22:42', 'trungtong@gmail.com','MN'),
(3, 25, '2022-07-16 15:26', 'matthews121@gmail.com','EM'),
(1, 26, '2022-07-15 22:33', 'System', ''),
(2, 26, '2022-07-17 21:47', 'kobi@gmail.com', 'EM'),
(3, 26, '2022-07-18 14:15', 'giaman@gmail.com', 'MN'),
(5, 26, '2022-07-19 11:43', 'giaman@gmail.com', 'MN'),
(1, 27, '2022-04-13 10:48', 'System', ''),
(2, 27, '2022-04-15 20:10', 'haanhtuan@gmail.com', 'EM'),
(3, 27, '2022-04-16 17:34', 'kobi@gmail.com', 'EM'),
(1, 28, '2022-06-10 21:53', 'System', ''),
(2, 28, '2022-06-11 16:13', 'matthews121@gmail.com','EM'),
(3, 28, '2022-06-12 22:50', 'haanhtuan@gmail.com', 'EM'),
(4, 28, '2022-06-13 20:53', 'giaman@gmail.com', 'MN'),
(1, 29, '2022-06-22 13:27', 'System', ''),
(2, 29, '2022-06-24 15:53', 'haanhtuan@gmail.com', 'EM'),
(3, 29, '2022-06-26 19:37', 'giaman@gmail.com', 'MN'),
(4, 29, '2022-06-28 19:45', 'giaman@gmail.com', 'MN'),
(1, 30, '2022-05-22 11:24', 'System', ''),
(2, 30, '2022-05-24 17:44', 'matthews121@gmail.com','EM'),
(3, 30, '2022-05-25 17:23', 'matthews121@gmail.com','EM'),
(4, 30, '2022-05-27 15:44', 'haanhtuan@gmail.com', 'EM'),
(6, 30, '2022-05-28 20:38', 'kobi@gmail.com', 'EM'),
(7, 30, '2022-05-29 19:34', 'giaman@gmail.com', 'MN'),
(1, 31, '2022-07-10 19:42', 'System', ''),
(2, 31, '2022-07-12 16:33', 'kobi@gmail.com', 'EM'),
(3, 31, '2022-07-13 14:30', 'trungtong@gmail.com','MN'),
(4, 31, '2022-07-15 23:29', 'matthews121@gmail.com','EM'),
(1, 32, '2022-07-23 11:48', 'System', ''),
(2, 32, '2022-07-25 14:39', 'kobi@gmail.com', 'EM'),
(3, 32, '2022-07-27 21:52', 'kobi@gmail.com', 'EM'),
(5, 32, '2022-07-29 18:20', 'matthews121@gmail.com','EM'),
(1, 33, '2022-06-10 20:18', 'System', ''),
(2, 33, '2022-06-12 20:46', 'giaman@gmail.com', 'MN'),
(3, 33, '2022-06-13 18:11', 'giaman@gmail.com', 'MN'),
(4, 33, '2022-06-15 18:37', 'trungtong@gmail.com','MN'),
(1, 34, '2022-06-13 12:34', 'System', ''),
(2, 34, '2022-06-15 18:36', 'matthews121@gmail.com','EM'),
(3, 34, '2022-06-17 13:39', 'haanhtuan@gmail.com', 'EM'),
(4, 34, '2022-06-18 12:26', 'trungtong@gmail.com','MN'),
(1, 35, '2022-07-12 18:20', 'System', ''),
(2, 35, '2022-07-14 12:18', 'trungtong@gmail.com','MN'),
(3, 35, '2022-07-16 17:15', 'giaman@gmail.com', 'MN'),
(1, 36, '2022-05-19 21:25', 'System', ''),
(2, 36, '2022-05-21 19:23', 'kobi@gmail.com', 'EM'),
(3, 36, '2022-05-22 18:45', 'kobi@gmail.com', 'EM'),
(4, 36, '2022-05-23 16:15', 'haanhtuan@gmail.com', 'EM'),
(1, 37, '2022-05-23 19:32', 'System', ''),
(2, 37, '2022-05-25 16:12', 'kobi@gmail.com', 'EM'),
(3, 37, '2022-05-26 15:17', 'kobi@gmail.com', 'EM'),
(4, 37, '2022-05-28 23:55', 'kobi@gmail.com', 'EM'),
(1, 38, '2022-07-17 19:42', 'System', ''),
(2, 38, '2022-07-18 11:40', 'kobi@gmail.com', 'EM'),
(3, 38, '2022-07-20 19:36', 'giaman@gmail.com', 'MN'),
(4, 38, '2022-07-21 17:10', 'matthews121@gmail.com','EM'),
(1, 39, '2022-07-21 17:59', 'System', ''),
(2, 39, '2022-07-22 19:25', 'giaman@gmail.com', 'MN'),
(3, 39, '2022-07-23 23:30', 'haanhtuan@gmail.com', 'EM'),
(1, 40, '2022-05-22 21:50', 'System', ''),
(2, 40, '2022-05-24 16:55', 'trungtong@gmail.com','MN'),
(3, 40, '2022-05-25 10:13', 'kobi@gmail.com', 'EM'),
(4, 40, '2022-05-27 11:57', 'haanhtuan@gmail.com', 'EM'),
(1, 41, '2022-05-10 12:18', 'System', ''),
(2, 41, '2022-05-12 15:13', 'haanhtuan@gmail.com', 'EM'),
(3, 41, '2022-05-14 15:31', 'kobi@gmail.com', 'EM'),
(1, 42, '2022-07-16 22:44', 'System', ''),
(2, 42, '2022-07-18 11:23', 'kobi@gmail.com', 'EM'),
(3, 42, '2022-07-20 21:13', 'trungtong@gmail.com','MN'),
(4, 42, '2022-07-22 17:53', 'giaman@gmail.com', 'MN'),
(6, 42, '2022-07-23 23:51', 'trungtong@gmail.com','MN'),
(7, 42, '2022-07-25 11:46', 'haanhtuan@gmail.com', 'EM'),
(1, 43, '2022-04-23 13:26', 'System', ''),
(2, 43, '2022-04-25 15:33', 'trungtong@gmail.com','MN'),
(3, 43, '2022-04-26 11:39', 'kobi@gmail.com', 'EM'),
(4, 43, '2022-04-28 15:26', 'matthews121@gmail.com','EM'),
(1, 44, '2022-06-19 21:15', 'System', ''),
(2, 44, '2022-06-21 18:39', 'matthews121@gmail.com','EM'),
(3, 44, '2022-06-23 14:22', 'matthews121@gmail.com','EM'),
(4, 44, '2022-06-25 15:22', 'trungtong@gmail.com','MN'),
(1, 45, '2022-04-16 14:24', 'System', ''),
(2, 45, '2022-04-17 18:55', 'giaman@gmail.com', 'MN'),
(3, 45, '2022-04-18 16:46', 'haanhtuan@gmail.com', 'EM'),
(4, 45, '2022-04-20 13:52', 'matthews121@gmail.com','EM'),
(1, 46, '2022-07-23 19:57', 'System', ''),
(2, 46, '2022-07-25 20:51', 'kobi@gmail.com', 'EM'),
(3, 46, '2022-07-26 13:33', 'giaman@gmail.com', 'MN'),
(4, 46, '2022-07-28 10:57', 'trungtong@gmail.com','MN'),
(1, 47, '2022-07-12 19:26', 'System', ''),
(2, 47, '2022-07-14 15:18', 'matthews121@gmail.com','EM'),
(3, 47, '2022-07-16 12:26', 'trungtong@gmail.com','MN'),
(4, 47, '2022-07-17 16:58', 'haanhtuan@gmail.com', 'EM'),
(1, 48, '2022-04-22 17:20', 'System', ''),
(2, 48, '2022-04-23 21:26', 'giaman@gmail.com', 'MN'),
(3, 48, '2022-04-24 21:33', 'matthews121@gmail.com','EM'),
(4, 48, '2022-04-25 10:30', 'trungtong@gmail.com','MN'),
(1, 49, '2022-06-10 17:18', 'System', ''),
(2, 49, '2022-06-11 19:59', 'giaman@gmail.com', 'MN'),
(3, 49, '2022-06-13 21:25', 'haanhtuan@gmail.com', 'EM'),
(4, 49, '2022-06-14 10:59', 'kobi@gmail.com', 'EM'),
(1, 50, '2022-07-23 14:35', 'System', ''),
(2, 50, '2022-07-25 20:27', 'giaman@gmail.com', 'MN'),
(3, 50, '2022-07-27 12:29', 'giaman@gmail.com', 'MN'),
(1, 51, '2022-07-19 10:34', 'System', ''),
(2, 51, '2022-07-21 12:13', 'giaman@gmail.com', 'MN'),
(3, 51, '2022-07-23 17:16', 'haanhtuan@gmail.com', 'EM'),
(4, 51, '2022-07-25 15:16', 'matthews121@gmail.com','EM'),
(1, 52, '2022-05-14 14:22', 'System', ''),
(2, 52, '2022-05-16 13:54', 'giaman@gmail.com', 'MN'),
(3, 52, '2022-05-18 12:36', 'kobi@gmail.com', 'EM'),
(1, 53, '2022-07-22 10:59', 'System', ''),
(2, 53, '2022-07-23 15:23', 'giaman@gmail.com', 'MN'),
(3, 53, '2022-07-24 21:32', 'trungtong@gmail.com','MN'),
(1, 54, '2022-04-21 12:52', 'System', ''),
(2, 54, '2022-04-23 12:37', 'matthews121@gmail.com','EM'),
(3, 54, '2022-04-25 18:54', 'kobi@gmail.com', 'EM'),
(4, 54, '2022-04-27 14:58', 'kobi@gmail.com', 'EM'),
(1, 55, '2022-07-22 15:15', 'System', ''),
(2, 55, '2022-07-24 15:16', 'giaman@gmail.com', 'MN'),
(3, 55, '2022-07-26 20:51', 'giaman@gmail.com', 'MN'),
(4, 55, '2022-07-28 17:21', 'giaman@gmail.com', 'MN'),
(1, 56, '2022-05-23 20:22', 'System', ''),
(2, 56, '2022-05-25 16:14', 'trungtong@gmail.com','MN'),
(3, 56, '2022-05-26 19:20', 'kobi@gmail.com', 'EM'),
(1, 57, '2022-06-15 18:36', 'System', ''),
(2, 57, '2022-06-16 19:51', 'kobi@gmail.com', 'EM'),
(3, 57, '2022-06-17 23:51', 'giaman@gmail.com', 'MN'),
(4, 57, '2022-06-19 15:48', 'haanhtuan@gmail.com', 'EM'),
(1, 58, '2022-05-20 22:55', 'System', ''),
(2, 58, '2022-05-22 11:38', 'trungtong@gmail.com','MN'),
(3, 58, '2022-05-23 12:58', 'giaman@gmail.com', 'MN'),
(1, 59, '2022-06-21 10:17', 'System', ''),
(2, 59, '2022-06-23 14:12', 'matthews121@gmail.com','EM'),
(3, 59, '2022-06-24 14:15', 'kobi@gmail.com', 'EM'),
(4, 59, '2022-06-26 23:52', 'trungtong@gmail.com','MN'),
(1, 60, CAST(N'2022-07-21T22:49:00' AS SmallDateTime), N'System', N''),
(1, 61, CAST(N'2022-07-21T22:55:00' AS SmallDateTime), N'System', N''),
(1, 62, CAST(N'2022-07-21T22:57:00' AS SmallDateTime), N'System', N''),
(1, 63, CAST(N'2022-07-21T22:59:00' AS SmallDateTime), N'System', N''),
(1, 64, CAST(N'2022-07-21T23:02:00' AS SmallDateTime), N'System', N''),
(1, 65, CAST(N'2022-07-21T23:13:00' AS SmallDateTime), N'System', N''),
(2, 60, CAST(N'2022-07-21T23:16:00' AS SmallDateTime), N'trungtong@gmail.com', N'MN'),
(2, 61, CAST(N'2022-07-21T23:16:00' AS SmallDateTime), N'trungtong@gmail.com', N'MN'),
(2, 64, CAST(N'2022-07-21T23:17:00' AS SmallDateTime), N'trungtong@gmail.com', N'MN'),
(3, 60, CAST(N'2022-07-21T23:19:00' AS SmallDateTime), N'trungtong@gmail.com', N'MN'),
(4, 60, CAST(N'2022-07-21T23:23:00' AS SmallDateTime), N'khanhtran@gmail.com', N'MN'),
(5, 65, CAST(N'2022-07-21T23:29:00' AS SmallDateTime), N'khanhtran@gmail.com', N'MN'),
(3, 61, CAST(N'2022-07-21T23:30:00' AS SmallDateTime), N'khanhtran@gmail.com', N'MN'),
(4, 61, CAST(N'2022-07-21T23:30:00' AS SmallDateTime), N'khanhtran@gmail.com', N'MN'),
(3, 62, CAST(N'2022-07-22T00:10:00' AS SmallDateTime), N'trungtong@gmail.com', N'MN'),
(2, 63, CAST(N'2022-07-22T00:14:00' AS SmallDateTime), N'trungtong@gmail.com', N'MN'),
(8, 61, CAST(N'2022-07-22T00:14:00' AS SmallDateTime), N'giaman@gmail.com', N'MN')

----tblOrderStatusUpdate(ID{identity}, statusID, orderID, updateDate, modifiedBy, role)----

GO

INSERT INTO tblReturns VALUES
(89, 1, N'Đổi', '2022-07-22', N'Đổi size: Đen/L --> Đen/XL')

---tblReturns(id [identity], detailID , quantity, returnType, returnDate, note)----

GO

CREATE FUNCTION [dbo].[fuChuyenCoDauThanhKhongDau] (@text nvarchar(max)) 
RETURNS nvarchar(max) 
AS 
BEGIN 	
SET @text = LOWER(@text) 	
DECLARE @textLen int = LEN(@text) 	
IF @textLen > 0 	
BEGIN 		
DECLARE @index int = 1 		
DECLARE @lPos int 		
DECLARE @SIGN_CHARS nvarchar(100) = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệếìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵýđð' 		
DECLARE @UNSIGN_CHARS varchar(100) = 'aadeoouaaaaaaaaaaaaaaaeeeeeeeeeeiiiiiooooooooooooooouuuuuuuuuuyyyyydd' WHILE @index <= @textLen 
BEGIN 			
SET @lPos = CHARINDEX(SUBSTRING(@text,@index,1),@SIGN_CHARS) 	
IF @lPos > 0 	
BEGIN 			
SET @text = STUFF(@text,@index,1,SUBSTRING(@UNSIGN_CHARS,@lPos,1)) 		
END 			
SET @index = @index + 1
 	END 
END 
RETURN @text
 END

GO

CREATE FUNCTION [dbo].[fuChuyenCoDauThanhKhongDauCoGach] (@text nvarchar(max)) 
RETURNS nvarchar(max) 
AS 
BEGIN 	
SET @text = LOWER(@text) 	
DECLARE @textLen int = LEN(@text) 	
IF @textLen > 0 	
BEGIN 		
DECLARE @index int = 1 		
DECLARE @lPos int 		
DECLARE @SIGN_CHARS nvarchar(100) = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệếìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵýđð' 		
DECLARE @UNSIGN_CHARS varchar(100) = 'aadeoouaaaaaaaaaaaaaaaeeeeeeeeeeiiiiiooooooooooooooouuuuuuuuuuyyyyydd' WHILE @index <= @textLen 
BEGIN 			
SET @lPos = CHARINDEX(SUBSTRING(@text,@index,1),@SIGN_CHARS) 	
IF @lPos > 0 	
BEGIN 			
SET @text = STUFF(@text,@index,1,SUBSTRING(@UNSIGN_CHARS,@lPos,1)) 		
END 			
SET @index = @index + 1
 	END 
END 
SET @text = REPLACE(@text,' ','-')
RETURN @text
 END


go
CREATE VIEW orderReview AS
SELECT t2.ID, t1.orderID, orderDate, total, t1.userID, t4.fullName, t2.statusID, statusName, [dbo].[fuChuyenCoDauThanhKhongDau](t4.fullName) as [TenKhongDau], payType, trackingID, t1.fullName as [orderFullName], t1.[address], t1.phone, email, note, transactionNumber 
FROM tblOrder t1 JOIN tblOrderStatusUpdate t2 ON t1.orderID = t2.orderID JOIN tblOrderStatus t3 ON t2.statusID = t3.statusID JOIN tblUsers t4 ON t1.userID = t4.userID;



go
CREATE VIEW currentStatusRow AS
SELECT orderID, MAX(ID) as ID
FROM tblOrderStatusUpdate
GROUP BY orderID


