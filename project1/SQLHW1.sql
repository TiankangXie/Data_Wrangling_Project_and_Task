drop table txie.Demo1;
-- Problem1 a
select * into txie.Demo1 from Demographics;
exec sp_rename 'txie.Demo1.tri_age','Age';
exec sp_rename 'txie.Demo1.gendercode','Gender';
exec sp_rename 'txie.Demo1.contactid','ID';
exec sp_rename 'txie.Demo1.address1_stateorprovince','State';
exec sp_rename 'txie.Demo1.[tri_imaginecareenrollmentemailsentdate]','EmailSentdate';
exec sp_rename 'txie.Demo1.tri_enrollmentcompletedate','Completedate';

-- Problem1 b
alter table txie.Demo1
ADD Diff int;
update txie.Demo1 
set Diff = DateDiff(day, try_convert(date,EmailSentdate), try_convert(date,Completedate));


-- Problem 2
ALTER TABLE txie.Demo1
ADD Enrollment_Status NVARCHAR(50);

update txie.Demo1
set Enrollment_Status = 'Complete' where [tri_imaginecareenrollmentstatus] = 167410011;
update txie.Demo1
set Enrollment_Status = 'Email sent' where [tri_imaginecareenrollmentstatus] = 167410001;
update txie.Demo1
set Enrollment_Status = 'Non responder' where [tri_imaginecareenrollmentstatus] = 167410004;
update txie.Demo1
set Enrollment_Status = 'Facilitated Enrollment' where [tri_imaginecareenrollmentstatus] = 167410005;
update txie.Demo1
set Enrollment_Status = 'Incomplete Enrollment' where [tri_imaginecareenrollmentstatus] = 167410002;
update txie.Demo1
set Enrollment_Status = 'Opted Out' where [tri_imaginecareenrollmentstatus] = 167410003;
update txie.Demo1
set Enrollment_Status = 'Unprocessed' where [tri_imaginecareenrollmentstatus] = 167410000;
update txie.Demo1
set Enrollment_Status = 'Second email sent' where [tri_imaginecareenrollmentstatus] = 167410006;



-- Problem3

Alter table txie.Demo1
ADD Sex NVARCHAR(50);
UPDATE txie.Demo1
SET Sex = 'female' where Gender = '2';
update txie.Demo1
SET Sex = 'male' where Gender = '1';
update txie.Demo1
SET Sex = 'other' where Gender = '167410000';
update txie.Demo1
SET Sex = 'Unknown' where Gender = 'NULL';


--Problem 4
Alter table txie.Demo1
Add Age_Group NVARCHAR(50);
Update txie.Demo1
set Age_Group = '0-25' where Age between 0 and 25;
update txie.Demo1
set Age_Group = '25-50' where Age between 25 and 50;
update txie.Demo1
set Age_Group = '50-75' where Age between 50 and 75;
update txie.Demo1
set Age_Group = '75-100' where Age between 75 and 100;


---create random rows/
SELECT *FROM txie.Demo1
--ORDER BY RAND();