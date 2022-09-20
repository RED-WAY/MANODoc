/*Creation of the Database:*/
CREATE DATABASE MANOSecurity;

/*Command to use the database:*/
USE MANOSecurity;

/*MySQL Workbench*/

/*Creation of Company Table:*/
CREATE TABLE company (
	idCompany INT PRIMARY KEY AUTO_INCREMENT,
	companyName VARCHAR (50),
	companyEmail VARCHAR (90)
);

/*Description of the company table:*/
DESC company;

/*Company Data insertion:*/
INSERT INTO company VALUES
    (null, "Colegio da PM Penha", "colegiopmpen@outlook.com"),
    (null, "Colegio Dom Bosco", "colegiodombosco@outlook.com"),
    (null, "Escola Adventista do Sul", "adventistadosul@outlook.com"),
    (null, "Colegio da PM Centro", "colegiopmcen@outlook.com"),
    (null, "Colegio Grili Magalhães", "grilimagalhaes@outlook.com");

/*Creation of Consumer table*/
CREATE TABLE consumer (
	idConsumer INT PRIMARY KEY AUTO_INCREMENT,
	consumerName VARCHAR (50),
        consumerEmail VARCHAR (50),
	consumerPassword VARBINARY(150),
	management VARCHAR (8) CONSTRAINT chkManagement CHECK 
	(management = "MASTER" or management = "ADMIN" or management = "ANALIST")
	fkCompany INT,
        FOREIGN KEY (fkCompany) REFERENCES Company(idCompany)
);

/*Description of Consumer table*/
DESC Consumer;

/*Consumer data insertion*/
INSERT INTO consumer VALUES 
    (null, "Vinicius Mengo", "vinicinho@gmail.com", AES_ENCRYPT("Ab45579021"), "ADMIN", 2),
    (null, "Danillo Borba", "danborba@gmail.com", AES_ENCRYPT("Baa34569034"), "MASTER", 1),
    (null, "Paulo Ranea", "paulogono@hotmail.com", AES_ENCRYPT("UUU38535850"), "ADMIN", 3),
    (null, "Andrey Gigabyte", "andgiga@gmail.com", AES_ENCRYPT("Dew255948947"), "ADMIN", 4),
    (null, "Arthur Itaquerense", "artitaq@gmail.com", AES_ENCRYPT("bwf36234366"), "ADMIN", 5),
    (null, "Alvarenga Pizza", "alvspizza@outlook.com", AES_ENCRYPT("Bafw39597927"), "ANALIST", 3);

/*Creation of Family table*/
CREATE TABLE family (
	idFamily INT PRIMARY KEY AUTO_INCREMENT,
	familyName VARCHAR (15),
        accessLevel VARCHAR (45) CONSTRAINT chkAccessLevel CHECK 
	(accessLevel = "Student" OR accessLevel = "Junior" OR accessLevel = "InCharge" OR accessLevel = "Adm"),
	fkCompany INT,
	FOREIGN KEY (fkCompany) REFERENCES company (idCompany)
);

/*Description of Family table*/
DESC family;

/*Family data insertion*/
INSERT INTO family VALUES
    (null, "Grupo 1", "Adm", 2),
    (null, "Grupo 4", "InCharge", 3),
    (null, "12° Setor", "Junior", 1),
    (null, "Group 8", "Junior", 4),
    (null, "21° Setor", "Student", 1);

/*Creation of Operation table*/
CREATE TABLE operation (
	idOperation INT PRIMARY KEY AUTO_INCREMENT,
	operationName VARCHAR (50),
	operationPath VARCHAR (300),
	operationType CHAR (7) CONSTRAINT chkOperationType CHECK 
	(operationType = "web" or operationType = "desktop")
);

/*Description of Operation table*/
DESC operation;

/*Operation data insertion*/ 
INSERT INTO operation VALUES
	(null, "Google Classroom", "https://classroom.google.com/", "browser"),
    (null, "Plurall", "https://www.plurall.net/", "browser"),
    (null, "Visual Studio Code", "https://code.visualstudio.com/", "desktop"),
    (null, "MySQL Workbench", "https://www.mysql.com/", "desktop"),
    (null, "Outlook", "https://outlook.live.com/owa/", "browser"),
    (null, "Youtube", "https://www.youtube.com/?gl=BR&hl=pt", "browser");

/*Creation of Machine table*/
CREATE TABLE machine (
	idMachine INT PRIMARY KEY AUTO_INCREMENT,
    machineName VARCHAR (20),
    dtAdded DATETIME DEFAULT CURRENT_TIMESTAMP,
	nameUserAdder VARCHAR (50),
    fkConsumerAdder INT,
    FOREIGN KEY (fkConsumerAdder) REFERENCES consumer(idConsumer),
	fkCompany INT,
	FOREIGN KEY (fkCompany) REFERENCES company(idCompany),
	fkFamily INT,
    FOREIGN KEY (fkFamily) REFERENCES family(idFamily),
);

/*Description of Machine table*/
DESC machine;

/*Machine data insertion*/
INSERT INTO machine VALUES
	(null, "Chrome01", NOW(), "Marcos", 1, 2, 2),
    (null, "Chrome02", NOW(), "Rogério", 2, 2, 3),
    (null, "Chrome03", NOW(), "Rogério", 2, 2, 4),
    (null, "Chrome04", NOW(), "Caio", 3, 2, 5),
    (null, "Dell01", NOW(), "Claudio", 4, 1, 3),
    (null, "Samsung03", NOW(), "Miguel", 1, 5, 2),
    (null, "Samsung06", NOW(), "Guilherme", 2, 5, 3)
    ;

CREATE TABLE hardware (
	idHardware INT PRIMARY KEY AUTO_INCREMENT,
	CPU_Util TINYINT,
	RAM_Util TINYINT,
	HardDisk_Util TINYINT,
	Memory_Util TINYINT,
	CPU_Temp INT,
	fkMachine INT,
	FOREIGN KEY (fkMachine) REFERENCES machine(idMachine),
	fkOperation INT,
	FOREIGN KEY (fkOperation) REFERENCES operation(idOperation)	
);

DESC hardware;

INSERT INTO hardware VALUES 
	(null, 20, 15, 42, 5, 10, 2, 2)
	(null, 17, 34, 5, 25, 44, 1, 5)
	(null, 25, 46, 26, 41, 52, 4, 1)
	(null, 5, 56, 35, 47, 87, 3, 3)
	(null, 21, 44, 54, 74, 63, 4, 5)
	(null, 12, 17, 51, 73, 43, 5, 4);
    
/*Creation of LogKilledOperation table*/
CREATE TABLE logKilledOperation (
	idLogKilledOperation INT AUTO_INCREMENT,
	dtOperationKill DATETIME DEFAULT CURRENT_TIMESTAMP, 
	operationName VARCHAR (50),
	fkMachine INT,
    FOREIGN KEY (fkMachine) REFERENCES machine(idMachine),
    PRIMARY KEY (idLogKilledOperation, fkMachine)
);

/*Description of LogKilledOperation table*/
DESC logKilledOperation;

/*LogKilledOperation data insertion*/
INSERT INTO logKilledOperation VALUES 
	(null, NOW(), "vscode.running", 1),
    (null, NOW(), "steam.com.running", 2),
    (null, NOW(), "epicgames.com.running", 3),
    (null, NOW(), "minecraft.com.running", 4),
    (null, NOW(), "steam.com.running", 5), 
    (null, NOW(), "friv.com.running", 3);

/*Creation of OperationRunning table*/
CREATE TABLE operationRunning (
	idOperationRunning INT AUTO_INCREMENT,
	fkMachine INT,
	FOREIGN KEY (fkMachine) REFERENCES Machine(idMachine),
    fkOperation INT,
    FOREIGN KEY (fkOperation) REFERENCES Operation(idOperation),
    PRIMARY KEY (idOperationRunning, fkMachine, fkOperation),
    operationStats CHAR (7) CONSTRAINT chkOperationStats CHECK 
	(operationStats = "running" or operationStats = "stopped"),
    lastUsed DATETIME DEFAULT CURRENT_TIMESTAMP
);

/*Description of OperationRunning table*/
DESC operationRunning;

/*OperationRunning data insertion*/
INSERT INTO operationRunning VALUES
	(null, 5, 4, "running", NOW()),
    (null, 3, 3, "stopped", NOW()),
    (null, 4, 2, "running", NOW()),
    (null, 3, 4, "running", NOW()),
    (null, 1, 5, "stopped", NOW()),
    (null, 2, 2, "running", NOW());

/*Creation of OperationLog table*/
CREATE TABLE operationLog (
	idOperationLog INT AUTO_INCREMENT,
	fkOperation INT,
    FOREIGN KEY (fkOperation) REFERENCES operation(idOperation),
    fkFamily INT,
	FOREIGN KEY (fkFamily) REFERENCES family(idFamily),
    PRIMARY KEY (idOperationLog, fkOperation, fkCollection)
);

/*Description of Operation table*/
DESC operationLog;

/*OperationLog data insertion*/
INSERT INTO operationLog VALUES
	(null, 2, 1),
    (null, 3, 4),
    (null, 1, 3),
    (null, 1, 5),
    (null, 5, 1),
    (null, 4, 4);
    
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
INSERT INTO companyOperations VALUES 
	(null, 4, 3),
    (null, 1, 3),
    (null, 5, 4),
    (null, 3, 1),
    (null, 2, 2),
    (null, 2, 5);


/*Beginning of the selects (data showing):*/

SELECT * FROM consumer;
SELECT * FROM company;
SELECT * FROM machine;
SELECT * FROM hardware;
SELECT * FROM operationRunning;
SELECT * FROM operation;
SELECT * FROM family;
SELECT * FROM operationLog;
SELECT * FROM logKilledOperation;
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
