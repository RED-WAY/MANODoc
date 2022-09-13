CREATE DATABASE MANOSecurity;

USE MANOSecurity;

/* MySQL - WORKBENCH */

CREATE DATABASE ManoSecurity;
USE ManoSecurity;

CREATE TABLE Company (
	idCompany INT PRIMARY KEY AUTO_INCREMENT,
	companyName VARCHAR(50),
	companyEmail VARCHAR(90)
);
-- insert into Company(companyName, companyEmail)values
-- ('companyTest','companyemail@gmail.com');

CREATE TABLE Consumer (
	idConsumer INT PRIMARY KEY AUTO_INCREMENT,
	consumerName VARCHAR(50),
	consumerEmail VARCHAR(50),
	consumerPassword VARBINARY(150),
    fkCompany int, foreign key (fkCompany) references Company(idCompany)
);	
-- insert into Consumer(consumerName, consumerEmail, consumerPassword, fkCompany) values
-- ( "test","test@gmail.com", AES_ENCRYPT("test", "corinthians"), 1);

CREATE TABLE Sector (
	idSector INT PRIMARY KEY AUTO_INCREMENT,
	sectorName varchar(15),
	sectorLevel varchar(50)
);
-- insert into Sector(sectorName, sectorLevel)value
-- ('collection1', 'adm');

CREATE TABLE Machine (
	idMachine INT primary key  AUTO_INCREMENT,
	fkConsumerAdder int, foreign key (fkConsumerAdder) references Consumer(idConsumer),
    nameUserAdder varchar (50),
	fkCompany int, foreign key (fkCompany) references Company(idCompany),
    fkSector int,  foreign key (fkSector) references Sector(idSector),
    machineName  varchar(20),
	dtAdded TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP);

/*-----------------------------------------------------*/

/* SQL SERVER - AZURE */
CREATE TABLE user (
	idUser INT PRIMARY KEY IDENTITY(1,1),
	userName VARCHAR(50),
	userEmail VARCHAR(50),
	userPassword VARBINARY(150), /*VERIFY*/
	entryDate TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP /*VERIFY*/
);

CREATE TABLE post (
	idPost INT PRIMARY KEY IDENTITY(1,1),
	title VARCHAR(100),
	fkUser INT FOREIGN KEY REFERENCES user(idUser)
);
