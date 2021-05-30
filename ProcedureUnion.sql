/*
Nama   : Muhammad Keenan Fathurrahman
NIM    : 24060119130052
Kelas  : MBD A
*/

-- Membuat database
create database alumnae;

-- Mengaktifkan database
use alumnae;

-- Membuat tabel mahasiswa
create table mahasiswa
(nama varchar(30) not null,
nim char(14) primary key,
alamat varchar(100) not null,
kota varchar(20) not null,
sma_asal varchar(50) not null,
email varchar(30) not null);

-- Membuat tabel alumni
create table alumni
(nama varchar(30) not null,
kota varchar(20) not null,
sma_asal varchar(50) not null,
email varchar(30) primary key);

-- Mengisi data mahasiswa
insert into mahasiswa
values("Adi Tri Hardja","24060119120001","Jl.Letjen South Parman no.1", "Jakarta", "SMA 8 Jakarta", "adi3hardja@gmail.com"),
("Benny Hartono Chandra","24060119120002","Jl.Taman Sentosa Indah II blok A2 no.16", "Semarang", "SMA 1 Semarang", "BenHartono123@gmail.com"),
("Sucianty Yanti Santoso","24060119120010","Jl.Iskandarsyah Raya 7 no.25", "Cirebon", "SMA 3 Semarang", "SuciCute@gmail.com");
select * from mahasiswa;

-- Mengisi data alumni
insert into alumni
values("Hartanti Shinta Jayadi","Semarang","SMA 1 Semarang","HShintaJ@gmail.com"),
("Teguh Darma Hartanto","Jakarta","SMA 8 Jakarta","TeguhDH@gmail.com"),
("Wulan Ratu Agusalim","Jakarta","SMA 3 Semarang","WulanQueen@gmail.com");
select * from alumni;

DELIMITER $$
CREATE PROCEDURE getRecord (pkota varchar(20), psma_asal varchar(50))
BEGIN SELECT mahasiswa.nama AS 'Nama', mahasiswa.kota AS 'Kota', mahasiswa.sma_asal AS 'SMA'
FROM mahasiswa WHERE(mahasiswa.kota=pkota) or (mahasiswa.sma_asal=psma_asal)
UNION SELECT alumni.nama AS 'Nama', alumni.kota AS 'Kota', alumni.sma_asal AS 'SMA'
FROM alumni WHERE(alumni.kota=pkota) or (alumni.sma_asal=psma_asal);
END$$
DELIMITER ;

CALL getRecord('Jakarta', 'SMA 1 Semarang');

DROP PROCEDURE getRecord;
