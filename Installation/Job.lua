--[[
   $$$$$\  $$$$$$\  $$$$$$$\  
   \__$$ |$$  __$$\ $$  __$$\ 
      $$ |$$ /  $$ |$$ |  $$ |
      $$ |$$ |  $$ |$$$$$$$\ |
$$\   $$ |$$ |  $$ |$$  __$$\ 
$$ |  $$ |$$ |  $$ |$$ |  $$ |
\$$$$$$  | $$$$$$  |$$$$$$$  |
 \______/  \______/ \_______/                                                          
]]--



---- To add new jobs use this pattern ----

-- Change "society_job_name" / "JobName" / "society_job_name" and add to sql

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_job_name', 'JobName', 1)
;

INSERT INTO `addon_account_data` (account_name, money) VALUES
	('society_job_name', 50)
;
   
INSERT INTO `datastore` (name, label, shared) VALUES
	('society_job_name', 'JobName', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_job_name', 'JobName', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('job_name','JobName')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('job_name',0,'recruit','Name',20,'{}','{}'),
	('job_name',1,'novice','Name',40,'{}','{}'),
	('job_name',2,'experienced','Name',60,'{}','{}'),
	('job_name',3,'chief','Name',85,'{}','{}'),
	('job_name',4,'boss','Name',100,'{}','{}')
      
;



