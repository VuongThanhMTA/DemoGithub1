CREATE DATABASE QuanLyKhuVuiChoiGT

USE QuanLyKhuVuiChoiGT

CREATE TABLE KhuVuc(
	MaKhu CHAR(5),
	TenKhu NVARCHAR(50),
	MaTruongKhu CHAR(5),
	ViTri NVARCHAR(50),
	ChucNang NVARCHAR(50),
	GiaNL INT,
	GiaTE INT,
	PRIMARY KEY(MaKhu),
	--FOREIGN KEY(MaTruongKhu) REFERENCES NhanVien
)

CREATE TABLE NhanVien(
	MaNV CHAR(5),
	TenNV NVARCHAR(50),
	GioiTinh NVARCHAR(5),
	CHECK(GioiTinh IN(N'Nam', N'Nữ')),
	Luong INT,
	MaKhu CHAR(5),
	PRIMARY KEY(MaNV),
 	FOREIGN KEY (MaKhu) REFERENCES dbo.KhuVuc(MaKhu)
)
-- tạo khóa ngoại bảng KhuVuc
ALTER TABLE dbo.KhuVuc
ADD CONSTRAINT FK_KV_NV
FOREIGN KEY(MaTruongKhu) REFERENCES dbo.NhanVien(MaNV)

--
CREATE TABLE TroChoi(
		MaTC CHAR(5),
		TenTC NVARCHAR(50),
		MaKhu CHAR(5),
		PRIMARY KEY (MaTC),
		FOREIGN KEY (MaKhu) REFERENCES dbo.KhuVuc(MaKhu)
)

CREATE TABLE ThietBi(
	MaTB char(5),
	TenTB NVARCHAR(50),
	NgayBD DATE,
	MaTC CHAR(5),
	PRIMARY KEY (MaTB),
	FOREIGN KEY (MaTC) REFERENCES dbo.TroChoi(MaTC)
)

CREATE TABLE DichVu(
	MaDV CHAR(5),
	TenDV NVARCHAR(50),
	MaKhu CHAR(5),
	GiaDV INT
	PRIMARY KEY(MaDV),
	FOREIGN KEY(MaKhu) REFERENCES dbo.KhuVuc(MaKhu)
	
)

CREATE TABLE KhachHang(
	MaKH CHAR(5),
	TenKH NVARCHAR(50),
	Tuoi INT,
	GioiTinh NVARCHAR(5),
	CHECK (GioiTinh IN (N'Nam', N'Nữ')),
	PRIMARY KEY(MaKH)
)

CREATE TABLE VeChoi(
	SoVe CHAR(5),
	MaKhu CHAR(5),
	MaKH CHAR(5),
	NgayBan DATE,
	TongTien INT ,
	PRIMARY KEY (SoVe),
	FOREIGN KEY (MaKhu) REFERENCES dbo.KhuVuc(MaKhu),
	FOREIGN KEY(MaKH) REFERENCES dbo.KhachHang(MaKH)
)

CREATE TABLE Phieu(
	SoPhieu CHAR(5),
	MaKH CHAR(5),
	NgayMua DATE,
	TongTien INT,
	PRIMARY KEY(SoPhieu),
	FOREIGN KEY(MaKH) REFERENCES dbo.KhachHang(MaKH)  
)

CREATE TABLE PhieuDV(
	SoPhieu CHAR(5),
	MaDV CHAR(5),
	Gia INT,
	FOREIGN KEY(SoPhieu) REFERENCES dbo.Phieu(SoPhieu),
	FOREIGN KEY(MaDV) REFERENCES dbo.DichVu(MaDV) 

)
									----- Insert-----
-- KhuVuc
INSERT INTO dbo.KhuVuc( MaKhu ,TenKhu ,MaTruongKhu ,ViTri,ChucNang ,GiaNL ,GiaTE)
VALUES  ( 'K1' , N'Khu vuc 1' ,null ,N'Hà Nội' ,N'' , 100 ,50)

-- NhanVien
INSERT INTO dbo.NhanVien ( MaNV, TenNV, GioiTinh, Luong, MaKhu )
VALUES  ( 'NV01', N'Nguyễn Tuấn Anh', N'Nam', 5000000,'K1')

--TroChoi
INSERT INTO dbo.TroChoi( MaTC, TenTC, MaKhu )
VALUES  ( 'TC01',N'Tàu Lượn','K1')

-- ThietBi
INSERT INTO dbo.ThietBi
        ( MaTB, TenTB, NgayBD, MaTC )
VALUES  ( 'TB01', N'Máy 1',' 09/01/2017', 'TC01' )

-- dichvu
INSERT INTO dbo.DichVu
        ( MaDV, TenDV, MaKhu, GiaDV )
VALUES  ( '',N'', '',0)

-- KhachHang 
INSERT INTO dbo.KhachHang
        ( MaKH, TenKH, Tuoi, GioiTinh )
VALUES  ( '', N'',0, N'')

-- VeChoi
INSERT INTO dbo.VeChoi
        ( SoVe, MaKhu, MaKH, NgayBan, TongTien )
VALUES  ( '','','',GETDATE(),0)

-- Phieu
INSERT INTO dbo.Phieu
        ( SoPhieu, MaKH, NgayMua, TongTien )
VALUES  ( '',  '', GETDATE(), 0 )

-- PhieuDV
INSERT INTO dbo.PhieuDV
        ( SoPhieu, MaDV, Gia )
VALUES  ( '', '',0  )

