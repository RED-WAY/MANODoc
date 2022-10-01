/*Creation of the Database:*/
CREATE DATABASE MANOSecurity;

/*Command to use the database:*/
USE MANOSecurity;

/*MySQL Workbench*/

/*Creation of Company Table:*/
CREATE TABLE company (
	idCompany INT PRIMARY KEY AUTO_INCREMENT,
	companyName VARCHAR (50),
	companyEmail VARCHAR (90),
    CNPJ VARCHAR (14)
);

/*Description of the company table:*/
DESC company;

/*Company Data insertion:*/
INSERT INTO company VALUES
    (null, "Colegio da PM Penha", "colegiopmpen@outlook.com", "12345678901234"),
    (null, "Colegio Dom Bosco", "colegiodombosco@outlook.com", "09876543210987"),
    (null, "Escola Adventista do Sul", "adventistadosul@outlook.com", "12345654321234"),
    (null, "Colegio da PM Centro", "colegiopmcen@outlook.com", "09876567890987"),
    (null, "Colegio Grili Magalhães", "grilimagalhaes@outlook.com", "10293847565748");

/*Creation of Consumer table*/
CREATE TABLE consumer (
	idConsumer INT PRIMARY KEY AUTO_INCREMENT,
	consumerName VARCHAR (50),
	consumerEmail VARCHAR (50),
	consumerPassword VARBINARY(150),
	management VARCHAR (8), CONSTRAINT chkManagement CHECK 
	(management = "MASTER" or management = "ADMIN" or management = "ANALYST"),	
    dtAdded DATETIME DEFAULT CURRENT_TIMESTAMP,
	fkManager INT,
	FOREIGN KEY (fkManager) REFERENCES consumer(idConsumer),
    fkCompany INT,
	FOREIGN KEY (fkCompany) REFERENCES company(idCompany)
);

/*Description of Consumer table*/
DESC Consumer;

/*Consumer data insertion*/
INSERT INTO consumer VALUES 
	(null, "test", "test@gmail.com", AES_ENCRYPT("1234", "corinthians"), "MASTER", default, null, 1),
    (null, "test2", "test2@gmail.com", AES_ENCRYPT("1234", "corinthians"), "MASTER", default, null, 2),
    (null, "Danillo Borba", "danborba@gmail.com", AES_ENCRYPT("Baa34569034", "corinthians"), "MASTER", default, 1, 1),
    (null, "Paulo Ranea", "paulogono@hotmail.com", AES_ENCRYPT("UUU38535850", "corinthians"), "ADMIN", default, 2, 2),
    (null, "Andrey Gigabyte", "andgiga@gmail.com", AES_ENCRYPT("Dew255948947", "corinthians"), "ADMIN", default, 3, 1),
    (null, "Arthur Itaquerense", "artitaq@gmail.com", AES_ENCRYPT("bwf36234366", "corinthians"), "ANALYST", default, 1, 1),
    (null, "Vinicius Mengo", "vinicinho@gmail.com", AES_ENCRYPT("Ab45579021", "corinthians"), "ANALYST", default, null, 3);

/*Creation of Family table*/
CREATE TABLE family (
	idFamily INT PRIMARY KEY AUTO_INCREMENT,
	familyName VARCHAR (15),
	familyLevel VARCHAR (45), CONSTRAINT chkAccessLevel CHECK 
	(familyLevel = "Student" OR familyLevel = "Junior" OR familyLevel = "InCharge" OR familyLevel = "Adm"),
	fkCompany INT,
	FOREIGN KEY (fkCompany) REFERENCES company (idCompany)
);

/*Description of Family table*/
DESC family;

/*Family data insertion*/
/*
INSERT INTO family VALUES
    (null, "Grupo 1", "Adm", 2),
    (null, "Grupo 4", "InCharge", 3),
    (null, "12° Setor", "Junior", 1),
    (null, "Group 8", "Junior", 4),
    (null, "21° Setor", "Student", 1);
*/

/*Creation of Machine table*/
CREATE TABLE machine (
	idMachine INT PRIMARY KEY AUTO_INCREMENT,
    machineName VARCHAR (20),
    dtAdded DATETIME DEFAULT CURRENT_TIMESTAMP,
    isUsing CHAR(3) DEFAULT 'not', CONSTRAINT chkMachineUse CHECK 
	(isUsing = "yes" OR isUsing = "not"),
    fkConsumer INT,
    FOREIGN KEY (fkConsumer) REFERENCES consumer(idConsumer),
	fkCompany INT,
	FOREIGN KEY (fkCompany) REFERENCES company(idCompany),
	fkFamily INT,
    FOREIGN KEY (fkFamily) REFERENCES family(idFamily)
);

/*Description of Machine table*/
DESC machine;

/*Machine data insertion*/
/*
INSERT INTO machine VALUES
	(null, "Chrome01", NOW(), DEFAULT, 1, 2, 2),
    (null, "Chrome02", NOW(), DEFAULT, 2, 2, 3),
    (null, "Chrome03", NOW(), DEFAULT, 2, 2, 4),
    (null, "Chrome04", NOW(), DEFAULT, 3, 2, 5),
    (null, "Dell01", NOW(), DEFAULT, 4, 1, 3),
    (null, "Samsung03", NOW(), DEFAULT, 1, 5, 2),
    (null, "Samsung06", NOW(), DEFAULT, 2, 5, 3);
*/

/*Creation of Hardware table*/
CREATE TABLE hardware (
	idHardware INT PRIMARY KEY AUTO_INCREMENT,
	CPU_Util TINYINT,
	RAM_Util TINYINT,
	HardDisk_Util TINYINT,
	Memory_Util TINYINT,
	CPU_Temp INT,
	fkMachine INT,
	FOREIGN KEY (fkMachine) REFERENCES machine(idMachine)
);

/*Description of Hardware table*/
DESC hardware;

/*Hardware data insertion*/
/*
INSERT INTO hardware VALUES 
	(null, 15, 42, 5, 10, 10, 2),
	(null, 34, 5, 25, 44, 11, 5),
	(null, 46, 26, 41, 52, 9, 1),
	(null, 56, 35, 47, 87, 13, 3),
	(null, 44, 54, 74, 63, 8, 5),
	(null, 17, 51, 73, 43, 11, 4);
*/

/*Creation of Operation table*/
CREATE TABLE operation (
	idOperation INT PRIMARY KEY AUTO_INCREMENT,
	operationName VARCHAR (50),
	operationPath VARCHAR (300),
	operationType CHAR (7), CONSTRAINT chkOperationType CHECK 
	(operationType = "web" or operationType = "desktop")
);

/*Description of Operation table*/
DESC operation;

/*Operation data insertion*/ 
/*
INSERT INTO operation VALUES
	(null, "Google Classroom", "https://classroom.google.com/", "desktop"),
    (null, "Plurall", "https://www.plurall.net/", "web"),
    (null, "Visual Studio Code", "https://code.visualstudio.com/", "desktop"),
    (null, "MySQL Workbench", "https://www.mysql.com/", "desktop"),
    (null, "Outlook", "https://outlook.live.com/owa/", "web"),
    (null, "Youtube", "https://www.youtube.com/?gl=BR&hl=pt", "web");    
*/

/*Creation of CompanyOperations table*/
CREATE TABLE companyOperations (
	idCompanyOperations INT AUTO_INCREMENT,
	fkCompany INT,
	FOREIGN KEY (fkCompany) REFERENCES company(idCompany),
	fkOperation INT,
    FOREIGN KEY (fkOperation) REFERENCES operation(idOperation),
    PRIMARY KEY (idCompanyOperations, fkCompany, fkOperation)
);
    
/*Description of CompanyOperations table*/    
DESC companyOperations;

/*CompanyOperations data insertion*/
/*
INSERT INTO companyOperations VALUES 
	(null, 4, 3),
    (null, 1, 3),
    (null, 5, 4),
    (null, 3, 1),
    (null, 2, 2),
    (null, 2, 5);
*/

/*Creation of FamilyOperations table*/
CREATE TABLE familyOperations (
	idFamilyOperations INT AUTO_INCREMENT,
	fkCompanyOperations INT,
    FOREIGN KEY (fkCompanyOperations) REFERENCES companyOperations(idCompanyOperations),
    fkFamily INT,
	FOREIGN KEY (fkFamily) REFERENCES family(idFamily),
    PRIMARY KEY (idFamilyOperations, fkCompanyOperations, fkFamily)
);

/*Description of Operation table*/
DESC familyOperations;

/*FamilyOperations data insertion*/
/*
INSERT INTO familyOperations VALUES
	(null, 2, 1),
    (null, 3, 4),
    (null, 1, 3),
    (null, 1, 5),
    (null, 5, 1),
    (null, 4, 4);
*/
    
/*Creation of OperationRunning table*/
CREATE TABLE operationRunning (
	idOperationRunning INT AUTO_INCREMENT,
	fkMachine INT,
	FOREIGN KEY (fkMachine) REFERENCES Machine(idMachine),
    fkOperation INT,
    FOREIGN KEY (fkOperation) REFERENCES Operation(idOperation),
    PRIMARY KEY (idOperationRunning, fkMachine, fkOperation),
    operationStats CHAR (7), CONSTRAINT chkOperationStats CHECK 
	(operationStats = "running" or operationStats = "stopped"),
    lastUsed DATETIME DEFAULT CURRENT_TIMESTAMP
);

/*Description of OperationRunning table*/
DESC operationRunning;

/*OperationRunning data insertion*/
/*
INSERT INTO operationRunning VALUES
	(null, 1, 4, "running", NOW()),
    (null, 2, 3, "stopped", NOW()),
    (null, 3, 2, "running", NOW()),
    (null, 4, 4, "running", NOW()),
    (null, 5, 5, "stopped", NOW()),
    (null, 6, 2, "running", NOW());
*/


/*Beginning of the selects (data showing):*/

SELECT * FROM consumer;
SELECT * FROM company;
SELECT * FROM machine;
SELECT * FROM hardware;
SELECT * FROM operationRunning;
SELECT * FROM operation;
SELECT * FROM family;
SELECT * FROM familyOperations;
SELECT * FROM companyOperations;

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
