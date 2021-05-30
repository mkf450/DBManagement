/*
Nama   : Muhammad Keenan Fathurrahman
NIM    : 24060119130052
Kelas  : MBD A
*/

-- Membuat database
create database hospital;

-- Mengaktifkan database
use hospital;

-- Membuat tabel pasien
create table patients
(patient_id char(3) primary key,
patient_name varchar(30) not null,
patient_address varchar(100) not null,
patient_age char(2) not null);

-- Membuat tabel dokter
create table doctors
(doctor_id char(3) primary key,
doctor_name varchar(30) not null,
doctor_address varchar(100) not null);

-- Membuat tabel rekam medis
create table records
(record_id char(3) primary key,
diagnosis varchar(50) not null,
patient_id char(3) not null,
foreign key (patient_id) references patients (patient_id)
on delete restrict on update cascade,
doctor_id char(3) not null,
foreign key (doctor_id) references doctors (doctor_id));

-- Membuat tabel resep
create table prescriptions
(medicine_id char(3) primary key,
medicine_name varchar(25) not null,
medicine_category varchar(50) not null,
medicine_price int(5) not null,
record_id char(3) not null,
foreign key (record_id) references records (record_id)
on delete restrict on update cascade);

-- Mengisi data pasien
insert into patients
values("P01","Adi Tri Hardja","Jl.Letjen South Parman Kav 76 Wisma Calindra Lt 3", "48"),
("P02","Benny Hartono Chandra","Jl.Taman Sentosa Indah II blok A2 no.16, Cikarang", "35"),
("P03","Susila Suhendra Gunawan","Jl.RA Kartini 26 Ventura Bldg Lt 8,Cilandak Barat", "42"),
("P04","Iman Handoko Budiaman","Jl.Terusan Arjuna Slt Ruko Kebon Jeruk Baru Bl A/1,Kebon Jeruk", "30"),
("P05","Hendra Setiawan Tanudjaja","Jl.Bukit Barisan Dlm 3, Sumatera Utara, 20111", "24"),
("P06","Cahya Batari Kusuma","Jl.Pelajar Pejuang 45 80,Turangga", "29"),
("P07","Sugiarto Wira Sasmita","Jl.Arteri Kelapa Dua II Bl B/40,Kebon Jeruk", "32"),
("P08","Utari Ida Oesman","Jl.Kemandoran VIII 1 RT 009/11,Grogol Utara", "22"),
("P09","Intan Dewi Sudjarwadi","Jl.RA Kartini 26 Ventura Bldg Lt 8,Cilandak Barat", "28"),
("P10","Sucianty Yanti Santoso","Jl.Iskandarsyah Raya 7,Melawai", "33");

-- Mengisi data dokter
insert into doctors
values("D01","Hartanti Shinta Jayadi","Jl.Mangga Besar 5 D,Tamansari"),
("D02","Enora Putuhena","Jl.Jend Sudirman Kav 10-11 Midplaza 2 Lt 3,Karet Tengsin"),
("D03","Eka Dwi Widjaja","Jl.HOS Cokroaminoto 52 Ged Astra Daihatsu,Ubung Kaja"),
("D04","Eko Widya Sasmita","Jl.Prapanca Buntu 14 C"),
("D05","Cinta Susanti Setiawan","JL.Kapuk Kamal Raya 06 RT.010/011KEL. Cengkareng Timur 11730"),
("D06","Cahya Citra Lesmono","JL.Buncit Persada, No.1"),
("D07","Indah Utami Sutedja","Jl.Jend Gatot Subroto Kav 23 Graha BIP Lt 9,Karet Semanggi"),
("D08","Teguh Darma Hartanto","Jl.Alaydrus Petojo Utara, Jakarta 10120"),
("D09","Adi Budi Setiabudi","Jl.Pasar Minggu Raya Kav 34 Graha Sucofindo Lt 15,Kalibata"),
("D10","Wulan Ratu Agusalim","Jl.Cempaka Putih Raya B-42 RT 007/08,Cempaka Putih Timur");

-- Mengisi data rekam medis
insert into records
values("R01","Sakit kepala migrain","P06","D03"),
("R02","Mual-mual dan kembung","P03","D09"),
("R03","Diare normal","P02","D02"),
("R04","Sembelit normal","P04","D01"),
("R05","Demam normal","P10","D05"),
("R06","Gatal-gatal menular non alergi","P05","D06"),
("R07","Sesak nafas asthma","P09","D07"),
("R08","Menggigil demam kepanjangan","P01","D10"),
("R09","Batuk kering","P08","D04"),
("R10","Nyeri gusi","P07","D08");

-- Mengisi data resep
insert into prescriptions
values("M01", "Antihistamin","Chlorpheniramine maleate","63100","R09"),
("M02","Aspirin","NSID","56400","R01"),
("M03","Domperidone","Antiemetik","81900","R02"),
("M04","Paracetamol","Acetaminophen","32600","R05"),
("M05","Ibuprofen","Anti-inflammatory Nonsteroid","18500","R08"),
("M06","Laksatif Enema","PEG 400","89700","R04"),
("M07","Agonis Beta","Bronkodilator","47200","R07"),
("M08","Loperamide","Imodium","27800","R03"),
("M09","Antitusif","Dextromethorphan HBr","51300","R06"),
("M10","Naproxen","Anti-inflammatory Nonsteroid","21300","R10");

-- Membuat Tabel Log_diagnosis
CREATE TABLE log_diagnosis (
  log_id INT(10) primary key AUTO_INCREMENT,
  patient_id char(3) not null,
  foreign key (patient_id) references patients (patient_id)
  on delete restrict on update cascade,
  old_diagnosis VARCHAR(100),
  new_diagnosis VARCHAR(100) not null);

-- Membuat TRIGGER
DELIMITER $$
CREATE TRIGGER update_records
  AFTER UPDATE
  ON records
  FOR EACH ROW
BEGIN
  INSERT INTO log_diagnosis
  set patient_id = old.patient_id,
  old_diagnosis = old.diagnosis,
  new_diagnosis = new.diagnosis;
END$$
DELIMITER ;

-- Testing trigger
UPDATE records
SET diagnosis = 'Maag akut'
WHERE patient_id = 'P03';

-- lihat log diagnosis
SELECT * FROM  log_diagnosis;

-- Menghidupkan event_scheduler
SHOW VARIABLES LIKE 'event_scheduler';
SET GLOBAL event_scheduler = 1;

-- Membuat Event
DELIMITER $$
CREATE EVENT checkup
  ON SCHEDULE EVERY 1 MONTH DO
BEGIN
  INSERT INTO new_diagnosis
  set patient_id = 'P07',
  old_diagnosis = old.diagnosis,
  new_diagnosis = 'Cek gusi rutin';
END$$
DELIMITER ;
