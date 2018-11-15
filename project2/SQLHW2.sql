drop table txie.PC1
select * into txie.PC1 from PhoneCall;
-- P1
alter table txie.PC1
ADD EnrollmentGroup NVARCHAR(50);
update txie.PC1
set EnrollmentGroup = 'Clinical Alert' where [EncounterCode] = 125060000;
update txie.PC1
set EnrollmentGroup = 'Health Coaching' where [EncounterCode] = 125060001;
update txie.PC1
set EnrollmentGroup = 'Technical Question' where [EncounterCode] = 125060002;
update txie.PC1
set EnrollmentGroup = 'Administrative' where [EncounterCode] = 125060003;
update txie.PC1
set EnrollmentGroup = 'Other' where [EncounterCode] = 125060004;
update txie.PC1
set EnrollmentGroup = 'Lack of engagement' where [EncounterCode] = 125060005;

select * from txie.PC1
ORDER BY RAND();


-- P2
SELECT EnrollmentGroup, COUNT(*) AS 'num' FROM txie.PC1
GROUP BY EnrollmentGroup;


-- P3 (Merge)
select A.*,B.* from txie.PC1 A
inner join
CallDuration B
on A.[CustomerId] = B.tri_CustomerIDEntityReference


-- P4 (Question here to be answered)
--select * from CallDuration
--drop table txie.CD1
select * into txie.CD1 from CallDuration;
alter table txie.CD1
ADD CallTypes NVARCHAR(50);
update  txie.CD1
set CallTypes = 'Inbound' where  [CallType]= 1;
update  txie.CD1
set CallTypes = 'Outbound' where  [CallType]= 2;


SELECT [CallType], COUNT(*) AS 'num' FROM txie.CD1
GROUP BY [CallType];

alter table txie.CD1
ADD CallOutcomes NVARCHAR(50);
update  txie.CD1
set CallOutcomes = 'No response' where  [CallOutcome]= 1;
update  txie.CD1
set CallOutcomes = 'Left voice mail' where  [CallOutcome]= 2;
update txie.CD1
set CallOutcomes = 'successful' where [CallOutcome] = 3;

SELECT CallOutcomes, COUNT(*) AS 'num' FROM txie.CD1
GROUP BY CallOutcomes;






select distinct(EnrollmentGroup),avg([CallDuration]) AS 'average duration' from 
(
select A.*,B.* from txie.PC1 A
inner join
CallDuration B
on A.[CustomerId] = B.tri_CustomerIDEntityReference) AA
group by EnrollmentGroup;


-- P5 
SELECT    DATEPART(week,[TextSentDate]) AS 'WK',
          COUNT(*) AS 'Total',
		  SenderName
FROM      (
select A.*,B.*,C.* from Demographics A
inner join 
ChronicConditions B
on A.[contactid] = B.[tri_patientid]
inner join
dbo.Text C
on A.[contactid] = C.tri_contactId) AA
GROUP BY  DATEPART(week,[TextSentDate]),
		  SenderName
		  
order by 'WK';


-- P6
SELECT    DATEPART(week,[TextSentDate]) AS 'WK',
          COUNT(*) AS 'Total',
		  tri_name
FROM      (
select A.*,B.*,C.* from Demographics A
inner join 
ChronicConditions B
on A.[contactid] = B.[tri_patientid]
inner join
dbo.Text C
on A.[contactid] = C.tri_contactId) AA
GROUP BY  DATEPART(week,[TextSentDate]),
		  tri_name
		  
order by 'WK';

