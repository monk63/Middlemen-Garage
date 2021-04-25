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
 price DECIMAL(8,2),
 
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

-- Data Population
-- User
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (1,'Michael','Nana','Ofori','M','1999-04-02',0209535914,'Tema-Comm 18','michaelofori@gmail.com','Accra');
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (2,'Maureen',null,'Ofori','F','2000-06-09',0543287575,'Tema-Comm 18','maureenofori@gmail.com','Accra');
insert into User(user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values ( 3,'Rex',null,'Kwahu','M','1967-10-05',0208149179,'Atomic','rekwa@gmail.com','Madina');
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (4,'Kevin','Kofi','Atweri','M','1999-08-21',0269535001,'Abelkuma','atwerke@richmen.com','Lapas');
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (5,'Eze','Abena','Boateng','F','1997-01-01',0203434236,'Sakumono','ezeteng@yahoo.com','Tema');
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (6,'Diasy','Abena','Ewe','F','2001-04-24',0549535112,'Nungua','abenaewe@americaonline.com','Accra');
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (7,'Jesse','Kwabena','Ayin','M','1999-04-21',0260735444,'Lashibi','jessekw@gmail.com','Tema');
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (8,'Boateng','Kofi','Nkansah','M','1999-05-03',0541122095,'Sakumono','boatendnka@gmail.com','Tema');
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (9,'Francis',null,'Amoah','M','1999-02-21',0509535434,'Sakumono','francisamoah@gmail.com','Tema');
insert into User (user_id,fname,middlename,lname,gender,dob,contact,address,email,state) values (10,'Elijah','Book','Boateng','M','2001-11-26',0542234323,'Dansoman','elijahboat@gmail.com','Accra');

select *
from User;

-- Vehicle
insert into Vehicle (vehicle_vin,vehicle_make,engine_type,body_style,manufacture_year,color,transmission,condition_,price)values ('TY1231CM','Toyota Camry','Petrol','Sedan','2020-09-12','Red','Automatic','New',25000.00);

select *
from Vehicle;

-- Customer
insert into Customer (user_id,customer_id,vehicle_vin) values (1,00001,'TY1231CM');

select *
from Customer;

-- Salesperson
insert into Salesperson (user_id,salesperson_id,customer_id,vehicle_vin) values (2,10001,00001,'TY1231CM');

select *
from Salesperson;

-- Garage
insert into Garage (garage_id,garage_name,garage_city,garage_state,number_of_cars_avaliable,web_url,contact,salesperson_id,customer_id) values (20210001,'Charles Auto','Comm-18','Tema',94,'www.charlesauto.com',0204523332,10001,00001);

select *
from Garage;

-- Supplier
insert into Supplier (supplier_id,supplier_name,vehicle_make) values (50001,'T & J ventures','Toyota Camry');

select *
from Supplier;

-- Vehicle for Sale
insert into VehicleForSale (vehicle_vin,price) values ('TY1231CM',25000.00);

select *
from VehicleForSale ;

-- Appointment
insert into Appointment (salesperson_id,customer_id,appointment) values (10001,00001, '2021-02-27 12-12-34');

select *
from Appointment ;

-- Workshop
insert into Workshop(workshop_id,garage_id,number_of_cars_avaliable) values (101,20210001,453);

select *
from Workshop;

-- Warehouse
insert into Warehouse(warehouse_name,location,capacity,number_of_cars,workshop_id) values ('SWISS','Tema',900,550,101); 

select *
from Warehouse;

-- VehicleSold
insert into VehicleSold(vehicle_vin,price,date_Sold,customer_id)values('TY1231CM',25000.00, default,00001); 

select *
from VehicleSold;

-- Autopart
insert into Autopart (workshop_id,supplier_id,type_of_part,number_avaliable,price,vehicle_make) values (101,50001,'Rim',4,4000.00,'Mercedes_benz c300');

select *
from Autopart;

-- Car_Feature
insert into Car_Features(vehicle_vin,feature,color) values ('TY1231CM','Red leather seats',null);


select *
from Car_Features;


