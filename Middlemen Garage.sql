-- Michael Nana Kofi Ofori
--  MIDDLEMEN_GARAGE_74212023;
  
 -- Create a database called ‘MIDDLEMEN_GARAGE’  
DROP DATABASE IF EXISTS MIDDLEMEN_GARAGE_74212023;
CREATE DATABASE  MIDDLEMEN_GARAGE_74212023;
USE MIDDLEMEN_GARAGE_74212023;

-- User Table
CREATE TABLE  User (
  user_id int not null,
  fname varchar(60)  not null,
  middlename varchar(60),
  lname varchar(60)  not null,
  gender enum('M', 'F'),
 dob DATE,
 contact varchar(20) not null unique,
 address varchar(50) not null,
 email varchar(40) unique CHECK (email LIKE '%@%') NOT NULL,
 state varchar(50) ,
 
 primary key(user_id)
);

-- Vehicle Table
CREATE TABLE  Vehicle (
  vehicle_vin varchar(20) not null ,
  vehicle_make varchar(60) not null,
  engine_type varchar(60) not null,
  body_style varchar(30) not null,
  manufacture_year DATE,
  color varchar(30),
  transmission enum('Automatic', 'Maunal') not null,
  mileage int,
 condition_ varchar(30),
 price DECIMAL(9,2),
 
 primary key (vehicle_vin)
);

-- Customer Table
CREATE TABLE  Customer (
   user_id int not null ,
  customer_id int not null,
  vehicle_vin varchar(20) not null,
  
  primary key ( customer_id),
  foreign key (user_id) references User(user_id)    ON DELETE CASCADE,
  foreign key (vehicle_vin) references Vehicle(vehicle_vin)   ON DELETE CASCADE
);

-- SalesPerson table
CREATE TABLE Salesperson (
 user_id int not null,
  salesperson_id int not null,
  customer_id int not null,
  vehicle_vin varchar(20) not null,
  
   primary key (salesperson_id),
  foreign key (user_id) references User(user_id)  ON DELETE CASCADE,
	foreign key (customer_id) references Customer(customer_id)  ON DELETE CASCADE,
    foreign key (vehicle_vin) references Vehicle(Vehicle_vin)  ON DELETE CASCADE
);

-- Garage Table
CREATE TABLE Garage (
  garage_id int  not null,
  garage_name  varchar(60) not null,
  garage_city  varchar(60),
  garage_state  varchar(60) not null,
  number_of_cars_avaliable int,
  web_url varchar(80) check (web_url LIKE '%.com%') ,
  contact varchar(20) not null unique,
  salesperson_id int not null,
  customer_id int not null,
  
 primary key (garage_id),
 foreign key (salesperson_id) references Salesperson(salesperson_id) ON DELETE CASCADE,
 foreign key (customer_id) references Customer(customer_id) ON DELETE CASCADE
);

-- Supplier Table
CREATE TABLE Supplier (
  supplier_id int not null,
  supplier_name  varchar(60) unique,
  vehicle_make varchar(100),
  
  primary key(supplier_id)
);

-- VehicleForSale table
CREATE TABLE  VehicleForSale (
vehicle_vin varchar(20) not null,
price DECIMAL(8,2),

foreign key (vehicle_vin) references Vehicle(vehicle_vin) ON DELETE CASCADE
);

CREATE TABLE  Appointment (
    salesperson_id int not null,
    customer_id int not null,
    appointment DATETIME not null,
    
      foreign key (salesperson_id) references Salesperson(salesperson_id) ON DELETE CASCADE,
	foreign key (customer_id) references Customer(Customer_id) ON DELETE CASCADE
);

-- Workshop Table
CREATE TABLE  Workshop (
  workshop_id int auto_increment primary key,
  garage_id int not null,
  number_of_cars_avaliable int,  
  
foreign key (garage_id) references Garage(garage_id) ON DELETE CASCADE
);

-- Warehouse Table
CREATE TABLE Warehouse (
   warehouse_name  varchar(60),
   location varchar(60),
   capacity int,
   number_of_cars int,
   workshop_id int not null,
   
    foreign key (workshop_id) references Workshop(workshop_id)   ON DELETE CASCADE
);

-- Vehicle Sold table
CREATE TABLE VehicleSold (
 vehicle_vin varchar(20) not null,
 price DECIMAL(8,2),
 date_Sold  DATETIME DEFAULT CURRENT_TIMESTAMP,  -- default date
 customer_id int not null,
 
 foreign key (vehicle_vin) references Vehicle(vehicle_vin) ON DELETE CASCADE,
 foreign key (customer_id) references Customer(customer_id) ON DELETE CASCADE
);

-- Autopart table
CREATE TABLE  Autopart  (
   workshop_id int not null,
   supplier_id int not null,
   type_of_part varchar(70),
   number_Avaliable int,
   price DECIMAL(8,2),
   vehicle_make varchar(100),   
   
    foreign key (workshop_id) references Workshop(workshop_id)  ON DELETE CASCADE,  
    foreign key (supplier_id) references Supplier(supplier_id)  ON DELETE CASCADE 
);

-- Car Features Table
CREATE TABLE Car_Features (
    vehicle_vin varchar(20) not null,
    feature varchar (100) unique,
    color varchar(40),
    
    foreign key (vehicle_vin) references Vehicle(vehicle_vin) ON DELETE CASCADE
);

-- Task 2.3 Indexing table
-- 1. create an index on first name and last name of users.
CREATE INDEX user_fname_lname_index ON User (lname,fname);

-- 2 create an index on price of cars in ascending order.
CREATE INDEX price_index ON Vehicle (price asc);

-- 3 create index on vehicle vin.
CREATE INDEX vehicle_vin_index ON Vehicle(vehicle_vin);

-- 4 create index on garage name and location.
CREATE INDEX garage_index ON Garage(garage_name,garage_state);

-- 5 create index on supplier name. 
CREATE INDEX supplier_index ON Supplier(supplier_name);



-- Task 2.4
-- Data Population
-- User
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (1,'Michael','Nana','Ofori','M','1999-04-02',0209535914,'Tema-Comm 18','michaelofori@gmail.com','Tema');
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (2,'Maureen',null,'Ofori','F','2000-06-09',0543287575,'Tema-Comm 18','maureenofori@gmail.com','Accra');
insert into User(user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values ( 3,'Rex',null,'Kwahu','M','1967-10-05',0208149179,'Atomic','rekwa@gmail.com','Madina');
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (4,'Kevin','Kofi','Atweri','M','1999-08-21',0269535001,'Abelkuma','atwerke@richmen.com','Lapas');
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (5,'Eze','Abena','Boateng','F','1997-01-01',0203434236,'Sakumono','ezeteng@yahoo.com','Tema');
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (6,'Diasy','Abena','Ewe','F','2001-04-24',0549535112,'Nungua','abenaewe@americaonline.com','Accra');
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (7,'Jesse','Kwabena','Ayin','M','1999-04-21',0260735444,'Lashibi','jessekw@gmail.com','Tema');
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (8,'Boateng','Kofi','Nkansah','M','1999-05-03',0541122095,'Sakumono','boatendnka@gmail.com','Tema');
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (9,'Francis',null,'Amoah','M','1999-02-21',0509535434,'Sakumono','francisamoah@gmail.com','Tema');
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (10,'Elijah','Book','Boateng','M','2001-11-26',0542234323,'Dansoman','elijahboat@gmail.com','Accra');
insert into User values (11,'Bradley','Bands','Deku','M','2001-08-21',0552234323,'Cantoments','bbands@esports.com','Accra');
insert into User values (12,'Jesse','Koby','Abeya','M','2001-10-05',0262234112,'West-hills','Kobyjesse@gmail.com','Accra');
insert into User values (13,'Ato',null,'Sehyi','M','2001-7-7',0244534435,'Baatsone','atos@yahoo.com','Spintex');
insert into User values (14,'Neolle',null,'Deku','F','2001-05-1',0232234453,'Dansoman','neolle@outlook.com','Accra');
insert into User values (15,'Silas',null,'Sigman','M','2000-08-11',0542323324,'Wa','silass@esports.com','Upper_West');
insert into User values (16,'Elorm',null,'Ahiator','M','2001-09-12',0542231123,'Comm-17','elahitor@outlook.com','Tema');
insert into User values (17,'Rodney','Jojo','Cameroon','M','2000-01-30',0249404323,'Cantoments','rodneyjojo@gmail.com','Accra');
insert into User values (18,'Betsy','Dennise','East','F','2001-08-21',0257234323,'East-Legon','betsyeast@gmail.com','Accra');
insert into User values (19,'Rebecca','Afia','Apio','F','1998-09-17',0502454714,'Ablekuma','rebeccaapio@gmail.com','Klagon');
insert into User values (20,'Mathew','Rich','Nkwewdu','M','1995-11-20',0557634112,'East-legon','mathewrich@rich.com','Accra');
insert into User values (21,'Cyirl',null,'West','M','1998-03-20',0207634222,'Klagon','cwest@gmail.com','Accra');
insert into User values (22,'Excel',null,'Chukwu','M','1999-09-20',0547123112,'Comm-29','chcuexcel@gmail.com','Tema');
insert into User values (23,'Kelvin',null,'Anim','M','1999-12-21',0207632323,'Comm-1','keanim@gmail.com','Tema');
insert into User values (24,'Dickson','Etornam','Akubia','M','2000-11-20',0207634812,'Kwabenya','dicskson@yahoo.com','Aburi');
insert into User values (25,'Ohemma',null,'Baadoi','F','2000-05-4',0207634367,'East','ohemmabaa@gmail.com','Kumasi');
insert into User values (26,'Edith',null,'Kyei','F','2000-10-12',0247639393,'Nungua','edithk@gmail.com','Teshi');
insert into User values (27,'Nana','Adwoa','Newmann','F','2000-06-2',0207634234,'Comm-10','nanaadwoa@gmail.com','Tema');
insert into User values (28,'Maxwell','Poshe','Akrasi','M','1999-11-20',0557100156,'East-legon','maxwell@yahoo.com','Accra');
insert into User values (29,'Charles','Daniel','Aworyonyo','M','1998-02-24',0207634953,'Baastona','charlesdaw@apple.com','Spintex');

-- select *
-- from User;

-- Vehicle
insert into Vehicle (vehicle_vin,vehicle_make,engine_type,body_style,manufacture_year,color,transmission,condition_,price)values ('TY1231CM','Toyota Camry','Petrol','Sedan','2020-09-12','Red','Automatic','New',25000.00);
insert into Vehicle (vehicle_vin,vehicle_make,engine_type,body_style,manufacture_year,color,transmission,condition_,price) values  ('TY2321R4','Toyota Rav-4','Petrol','SUV','2021-09-12','Black','Automatic','New',45000.00);
insert into Vehicle  (vehicle_vin,vehicle_make,engine_type,body_style,manufacture_year,color,transmission,condition_,price) values  ('TY5912LC','Toyota Land crusier V8','Petrol','SUV','2018-10-21','Black','Automatic','Used',80000.00);
insert into Vehicle  (vehicle_vin,vehicle_make,engine_type,body_style,manufacture_year,color,transmission,condition_,price) values  ('MB6363AMG','Mercedes-Benz GLA','Electric','Hatch-back','2021-10-21','Blue','Automatic','New',65000.00);
insert into Vehicle  (vehicle_vin,vehicle_make,engine_type,body_style,manufacture_year,color,transmission,condition_,price) values  ('MB1963AMG','Mercedes Benz AMG E63','Petrol','SUV','2020-07-30','Ash','Automatic','New',105000.00);
insert into Vehicle  (vehicle_vin,vehicle_make,engine_type,body_style,manufacture_year,color,transmission,condition_,price) values  ('BM2511M4','BMW M4','Disel','Sedan','2010-09-12','Red','Maunal','Used',40000.00);
insert into Vehicle  (vehicle_vin,vehicle_make,engine_type,body_style,manufacture_year,color,transmission,condition_,price) values  ('BM2366X6','BMW X6','Petrol','SUV','2019-10-30','Black','Automatic','New',89000.00);
insert into Vehicle  (vehicle_vin,vehicle_make,engine_type,body_style,manufacture_year,color,transmission,condition_,price) values  ('TL2021MX','Telsa Model X','Electric','SUV','2019-10-30','White','Automatic','New',90000.00);
insert into Vehicle  (vehicle_vin,vehicle_make,engine_type,body_style,manufacture_year,color,transmission,condition_,price) values  ('TL2010MY','Telsa Model Y','Electric','Sedan','2020-11-01','Red','Automatic','New',55000.00);
insert into Vehicle  (vehicle_vin,vehicle_make,engine_type,body_style,manufacture_year,color,transmission,condition_,price) values  ('LR1956SV','Land Rover SV','Petrol','SUV','2019-10-30','Green','Automatic','New',120000.00);
insert into Vehicle  (vehicle_vin,vehicle_make,engine_type,body_style,manufacture_year,color,transmission,condition_,price) values  ('LR1967DF','Land Rover Defender','Petrol','SUV','2021-10-01','Black','Automatic','New',85000.00);

-- select *
-- from Vehicle;

-- Customer
insert into Customer (user_id,customer_id,vehicle_vin) values (1,00001,'TY1231CM');
insert into Customer  values (2,00002,'TY2321R4');
insert into Customer  values (3,00003,'TY5912LC');
insert into Customer  values (4,00004,'MB6363AMG');
insert into Customer  values (5,00005,'MB1963AMG');
insert into Customer  values (6,00006,'BM2366X6');
insert into Customer  values (7,00007,'TL2021MX');
insert into Customer  values (8,00008,'TL2010MY');
insert into Customer  values (9,00009,'BM2511M4');
insert into Customer  values (10,00010,'LR1967DF');

-- select *
-- from Customer;

-- Salesperson
insert into Salesperson (user_id,salesperson_id,customer_id,vehicle_vin) values (11,10001,00001,'TY1231CM');
insert into Salesperson values (12,10002,00002,'TY2321R4');
insert into Salesperson values (13,10003,00003,'TY5912LC');
insert into Salesperson values (14,10004,00004,'MB6363AMG');
insert into Salesperson values (15,10005,00005,'MB1963AMG');
insert into Salesperson values (16,10006,00006,'BM2366X6');
insert into Salesperson values (17,10007,00007,'TL2021MX');
insert into Salesperson values (18,10008,00008,'TL2010MY');
insert into Salesperson values (19,10009,00009,'BM2511M4');
insert into Salesperson values (20,10010,00010,'LR1967DF');


-- select *
-- from Salesperson;

-- Garage
insert into Garage (garage_id,garage_name,garage_city,garage_state,number_of_cars_avaliable,web_url,contact,salesperson_id,customer_id) values (20210001,'Charles Auto','Comm-18','Tema',94,'www.charlesauto.com',0204523332,10001,00001);
insert into Garage  values (20210002,'Swiss Group','Spintex Road','Spintex',500,'www.swissgroup.com',0302959494,10002,00002);
insert into Garage  values (20210003,'Fastlane Auto','Baastona','Spintex',250,null,0303959494,10003,00003);
insert into Garage  values (20210004,'Maybach Auto',null,'Tema',50,null,0302123432,10004,00004);
insert into Garage  values (20210005,'T % M Auto','COmm-19','Tema',100,null,03049594453,10005,00005);
insert into Garage  values (20210006,'Benz Garage','Baastona','Spintex',90,null,0306944494,10006,00006);
insert into Garage  values (20210007,'Hilus Group',null,'Tema-New Town',90,'www.hilusgroup.com',0301959445,10007,00007);
insert into Garage  values (20210008,'Phonix cars',null,'Kanshe',94,'www.phonixcars.com',0305959463,10008,00008);
insert into Garage  values (20210009,'Tullow Auto','Comm-18','Lashibi',60,'www.tullow.com',0300959443,10009,00009);
insert into Garage  values (20210010,'Carwow',null,'East Legon',200,'www.carwow.com',0302939434,10010,00010);

-- select *
-- from Garage;

-- Supplier
insert into Supplier (supplier_id,supplier_name,vehicle_make) values (50001,'T & J ventures','Toyota Camry');
insert into Supplier values (50002,'Tadi ventures','Toyota Prado');
insert into Supplier values (50003,'Boss ventures','Mercedes Benz');
insert into Supplier values (50004,'Charlesventures','BMW');
insert into Supplier values (50005,'Dubia logistcs','KIA');
insert into Supplier values (50006,'Heck logistics','Honda');
insert into Supplier values (50007,'Skull Logistics','Hyundia');
insert into Supplier values (50008,'REd-line ventures','Skoda');
insert into Supplier values (50009,'Red-bull ventures','Ferriari');
insert into Supplier values (50010,'Pertronas ventures','Maclaern');

-- select *
-- from Supplier;

-- Vehicle for Sale
insert into VehicleForSale (vehicle_vin,price) values ('TY1231CM',25000.00);
insert into VehicleForSale  values ('TY2321R4',45000.00);
insert into VehicleForSale  values ('TY5912LC',80000.00);
insert into VehicleForSale  values ('LR1967DF',85000.00);
insert into VehicleForSale  values ('BM2366X6',89000.00);

-- select *
-- from VehicleForSale ;

-- Appointment
insert into Appointment (salesperson_id,customer_id,appointment) values (10001,00001, '2021-02-27 12-12-00');
insert into Appointment  values (10002,00002, '2021-03-11 10-12-00');
insert into Appointment  values (10003,00003, '2021-04-21 12-12-00');
insert into Appointment values (10004,00004, '2021-05-23 12-00-00');
insert into Appointment  values (10005,00005, '2021-06-12 12-12-00');
insert into Appointment  values (10006,00006, '2021-07-6 12-10-00');

-- select *
-- from Appointment;

-- Workshop
insert into Workshop(workshop_id,garage_id,number_of_cars_avaliable) values (101,20210001,453);
insert into Workshop  values (102,20210002,43);
insert into Workshop  values (103,20210003,53);
insert into Workshop  values (104,20210004,40);
insert into Workshop  values (105,20210005,43);
insert into Workshop  values (106,20210006,53);
insert into Workshop  values (107,20210007,33);
insert into Workshop  values (108,20210008,43);
insert into Workshop  values (109,20210009,10);
insert into Workshop  values (110,20210010,20);

-- select *
-- from Workshop;

-- Warehouse
insert into Warehouse(warehouse_name,location,capacity,number_of_cars,workshop_id) values ('SWISS','Tema',900,550,101); 
insert into Warehouse  values ('Customs','Tema',950,50,102); 
insert into Warehouse  values ('Bond','Tema',950,100,103);
 insert into Warehouse  values ('Kingdom','Tema',950,80,104);
 insert into Warehouse  values ('Bonds','Tema',950,60,105); 

-- select *
-- from Warehouse;

-- VehicleSold
insert into VehicleSold(vehicle_vin,price,date_Sold,customer_id)values('TY1231CM',25000.00, default,00001); 
insert into VehicleSold values('TY2321R4',45000.00, '2021-07-6 12-10-00',00002); 
insert into VehicleSold values('TY5912LC',80000.00, '2021-07-6 12-10-00',00003); 
insert into VehicleSold values('MB6363AMG',65000.00, '2021-07-6 12-10-00',00004); 
insert into VehicleSold values('BM2511M4',105000.00, '2021-07-6 12-10-00',00005); 
insert into VehicleSold values('BM2511M4',40000.00, default,00006); 

-- select *
-- from VehicleSold;

-- Autopart
insert into Autopart (workshop_id,supplier_id,type_of_part,number_avaliable,price,vehicle_make) values (101,50001,'Rim',4,4000.00,'Mercedes_benz c300');
insert into Autopart  values (102,50002,'Brake Light',2,56.00,'Toyota Camry');
insert into Autopart  values (103,50003,'Steering Column',1,1200.00,'BMW M4');
insert into Autopart  values (104,50004,'Tyres',4,5000.00,'BMW X6');
insert into Autopart  values (105,50005,'Fuse',3,40.00,'Land Rover Defender');

-- select *
-- from Autopart;

-- Car_Feature
insert into Car_Features(vehicle_vin,feature,color) values ('TY1231CM','Red leather seats',null);
insert into Car_Features values ('MB1963AMG','Black leather seats',null);
insert into Car_Features values ('MB1963AMG','AMG exhaust','Raging Green');
insert into Car_Features values ('TL2010MY','White seats',null);
insert into Car_Features values ('TL2010MY','Long Range','Elon Blue');



-- select *
-- from Car_Features;

-- Task 2.5
-- Queries
-- 1.  Show the customer and cars they bought in acsending order by price.
SELECT Customer.customer_id,Vehicle.vehicle_vin,Vehicle.vehicle_make,Vehicle.price
From Customer
Inner Join Vehicle ON
Customer.vehicle_vin=Vehicle.vehicle_vin
ORDER BY Vehicle.price ASC;

-- 2 Show the cars each salesperson is assigned with customer. 
SELECT Salesperson.salesperson_id,Vehicle.vehicle_vin,Vehicle.vehicle_make,Vehicle.price, Customer.customer_id
From Salesperson
Inner Join Vehicle ON
Salesperson.vehicle_vin=Vehicle.vehicle_vin
 join Customer ON
Salesperson.customer_id=Customer.customer_id
ORDER BY Vehicle.price ASC;

-- 3. Selecting garages available in Tema
Select garage_name,garage_state,contact
from Garage
where garage_state='Tema';

-- 4. Union to join user and customer table to view all details of the customer.
SELECT * FROM User
LEFT JOIN Customer ON User.user_id = Customer.user_id
UNION
SELECT * FROM User
RIGHT JOIN Customer ON User.user_id = Customer.user_id;

-- 5 Show recent cars avaliable.
Select  vehicle_make,manufacture_year
from Vehicle
order by Vehicle.manufacture_year DESC; 

-- 6 Shows the salesperson appointment time with customer
SELECT Salesperson.salesperson_id, Customer.customer_id, Appointment.appointment
FROM Salesperson
INNER JOIN Appointment
ON Salesperson.salesperson_id = Appointment.salesperson_id
INNER JOIN Customer
ON Appointment.customer_id=  Customer.customer_id;

-- 7 Shows cars with special features
SELECT Vehicle.vehicle_make,Car_Features.feature
FROM Vehicle,Car_Features
WHERE Vehicle.vehicle_vin = Car_Features.vehicle_vin ;
 
 -- 8 Shows garages with websites
 SELECT *
 FROM Garage
 WHERE web_url like '%.com';





	
