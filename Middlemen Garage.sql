

DROP DATABASE IF EXISTS MIDDLEMEN_GARAGE_74212023;
CREATE DATABASE  MIDDLEMEN_GARAGE_74212023;
USE MIDDLEMEN_GARAGE_74212023;




CREATE TABLE  User (
  user_id int auto_increment primary key,
  fname varchar(60)  not null,
  middlename varchar(60)  not null,
  lname varchar(60)  not null,
  gender enum('M', 'F'),
 dob DATE,
 contact varchar(20) not null unique,
 address varchar(50) not null,
 email varchar(40) unique CHECK (email LIKE '%@%') NOT NULL,
 state varchar(50) not null
 
--  PRIMARY KEY (user_id)
);

CREATE TABLE  Vehicle (
  vehicle_vin int auto_increment primary key,
  vehicle_make varchar(60) not null,
  engine_type varchar(60) not null,
  body_style varchar(30) not null,
  manufacture_year DATE,
  color varchar(30),
  transmission enum('Automatic', 'Maunal') not null,
  mileage int,
 condition_ varchar(30),
 price DECIMAL(6,2)
  
--  PRIMARY KEY (vehicle_vin)
);

-- Customer Table
CREATE TABLE  Customer (
  customer_id int auto_increment primary key,
  user_id int not null,
  vehicle_vin int not null,
  
 -- PRIMARY KEY (customer_id),
  foreign key (user_id) references User(user_id),
  foreign key (vehicle_vin) references Vehicle(vehicle_vin)
);


CREATE TABLE SalesPerson (
  salesperson_id int auto_increment primary key,
  user_id int,
  vehicle_vin int,
  customer_id int not null,
  
 -- PRIMARY KEY (salesperson_id),
  foreign key (user_id) references User(user_id),
  foreign key (vehicle_vin) references Vehicle(Vehicle_vin),
	foreign key (customer_id) references Customer(customer_id)
);

CREATE TABLE Garage (
  garage_id int auto_increment primary key,
  garage_name  varchar(60) not null,
  garage_city  varchar(60),
  garage_state  varchar(60) not null,
  number_of_cars_avaliable int,
  web_url varchar(80),
  contact varchar(20) not null unique,
  salesperson_id int not null,
  customer_id int not null,
 
 -- PRIMARY KEY (garage_id),
 foreign key (Salesperson_id) references Salesperson(Salesperson_id),
 foreign key (customer_id) references Customer(customer_id)
);

CREATE TABLE Supplier (
  supplier_id int auto_increment primary key,
  supplier_name  varchar(60),
  vehicle_make varchar(100)
  
 -- PRIMARY KEY (suppliers_id)
);

CREATE TABLE  VehicleForSale (
vehicle_vin int not null,
price DECIMAL(6,2),

foreign key (vehicle_vin) references Vehicle(vehicle_vin)
);

CREATE TABLE  Appointment (
    salesperson_id int not null,
    customer_id int not null,
    appointment DATETIME not null,
    
      foreign key (Salesperson_id) references Salesperson(Salesperson_id),
	foreign key (customer_id) references Customer(Customer_id)
);

CREATE TABLE  Workshop (
  workshop_id int auto_increment primary key,
  garage_id int not null,
  number_of_cars_avaliable int,  
  
  -- PRIMARY KEY (workshop_id),
foreign key (garage_id) references Garage(garage_id)
);

CREATE TABLE Warehouse (
   workhouse_name  varchar(60),
   location varchar(60),
   capacity int,
   number_of_cars int,
   workshop_id int not null,
   
    foreign key (workshop_id) references Workshop(workshop_id)   
);

CREATE TABLE VehicleSold (
 vehicle_vin int,
 price DECIMAL(6,2),
 date_Sold DATE,
 customer_id int not null,
 
 foreign key (vehicle_vin) references Vehicle(vehicle_vin),
 foreign key (customer_id) references Customer(customer_id)
);

CREATE TABLE  Autopart  (
   workshop_id int not null,
   supplier_id int not null,
   type_of_part varchar(70),
   number_Avaliable int,
   price DECIMAL(6,2),
   vehicle_make varchar(100),   
   
    foreign key (workshop_id) references Workshop(workshop_id) ,  
    foreign key (supplier_id) references Supplier(supplier_id)   
);

CREATE TABLE Car_Features (
    vehicle_vin int,
    feature varchar (100),
    color varchar(40),
    
    foreign key (vehicle_vin) references Vehicle(vehicle_vin)
);



