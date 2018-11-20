--exec sp_rename 'txie.ICBP.BPAlerts','BP_status';

ALTER TABLE txie.ICBP
ADD BPstatus int null;

update txie.ICBP
set BPstatus = 1 where [BPAlerts] = 'Hypo1' or [BPAlerts] = 'Normal';
update txie.ICBP
set BPstatus = 0 where [BPAlerts] = 'Hypo2' or [BPAlerts] = 'HTN1'or [BPAlerts] = 'HTN2'or [BPAlerts] = 'HTN3';

drop table txie.Demo1
select * into txie.Demo1 from Demographics;
select * from txie.ICBP

select * from
(
select A.*,B.* from txie.ICBP A
left join
txie.Demo1 B
on A.[ID] = B.[contactid] )AA
order by contactid, ObservedTime;

-----P1d
---Potentially solution for 1d 1nd Version
select [ID] as 'ID', DATEDIFF(week, try_convert(date,[tri_enrollmentcompletedate]),[ObservedTime]) as weeks_ago, AVG([BPstatus]) as 'Average'
from (
select A.*,B.* from txie.ICBP A
inner join
txie.Demo1 B
on A.[ID] = B.[contactid] 
) AA
WHERE  DATEDIFF(week, try_convert(date,[tri_enrollmentcompletedate]), [ObservedTime]) <= 12 and DATEDIFF(week, try_convert(date,[tri_enrollmentcompletedate]), [ObservedTime]) >= 0 
group by ID, DATEDIFF(week, try_convert(date,[tri_enrollmentcompletedate]), [ObservedTime])


-----Second Solution for part 1d
select [ID] as 'ID', DATEDIFF(week, [NAMin], [ObservedTime]) as weeks_ago, AVG([BPstatus]) as 'Average'
from (
select t1.*, t2.[Min] as [NAMin]
from(
select A.*,B.* from txie.ICBP A
inner join
txie.Demo1 B
on A.[ID] = B.[contactid] 
) t1
left join
(
SELECT	 [ID] as 'ID', MIN([ObservedTime]) as 'Min'
FROM      (
select A.*,B.* from txie.ICBP A
inner join
txie.Demo1 B
on A.[ID] = B.[contactid] )AA
group by [ID]) t2
on t1.contactid = t2.ID
 )AA
WHERE  DATEDIFF(week, [NAMin], [ObservedTime]) <= 12

group by ID, DATEDIFF(week, [NAMin], [ObservedTime])



-----part 1e 1st version
select t1.ID, t1.[12WKAverage], COALESCE(t2.[1WKAverage],0) as [1WKAverage]
from (SELECT	 [ID] as 'ID',
		 AVG([BPstatus]) as '12WKAverage'
FROM      (
select A.*,B.* from txie.ICBP A
inner join
txie.Demo1 B
on A.[ID] = B.[contactid] )AA
where [ObservedTime] between DATEADD(week, 12, try_convert(date,[tri_enrollmentcompletedate])) and 
DATEADD(week, 13, try_convert(date,[tri_enrollmentcompletedate]))
--GROUP BY  [ID],[ObservedTime],[tri_enrollmentcompletedate]
group by [ID]) t1
inner Join
(SELECT	 [ID] as 'ID',
		 AVG([BPstatus]) as '1WKAverage'
FROM      (
select A.*,B.* from txie.ICBP A
left join
txie.Demo1 B
on A.[ID] = B.[contactid] )AA
where [ObservedTime] between try_convert(date,[tri_enrollmentcompletedate]) and 
DATEADD(week, 1, try_convert(date,[tri_enrollmentcompletedate]))
--GROUP BY  [ID],[ObservedTime],[tri_imaginecareenrollmentemailsentdate]
group by [ID]) t2
on (t1.ID = t2.ID);


-------Part 1e 2nd solution
select * into txie.MinCalc from(
select t1.*, t2.[Min] as [NAMin]
from(
select A.*,B.* from txie.ICBP A
inner join
txie.Demo1 B
on A.[ID] = B.[contactid] 
) t1
left join
(
SELECT	 [ID] as 'ID', MIN([ObservedTime]) as 'Min'
FROM      (
select A.*,B.* from txie.ICBP A
inner join
txie.Demo1 B
on A.[ID] = B.[contactid] )AA
group by [ID]) t2
on t1.contactid = t2.ID ) AA

select t1.ID, t1.[12WKAverage], COALESCE(t2.[1WKAverage],0) as [1WKAverage]
from (SELECT	 [ID] as 'ID',
		 AVG([BPstatus]) as '12WKAverage'
FROM  txie.MinCalc
where [ObservedTime] between DATEADD(week, 12, try_convert(date,[NAMin])) and 
DATEADD(week, 13, try_convert(date,[NAMin]))
--GROUP BY  [ID],[ObservedTime],[tri_enrollmentcompletedate]
group by [ID]) t1
inner Join
(SELECT	 [ID] as 'ID',
		 AVG([BPstatus]) as '1WKAverage'
FROM    txie.MinCalc
where [ObservedTime] between try_convert(date,[NAMin]) and 
DATEADD(week, 1, try_convert(date,[NAMin]))
group by [ID]) t2
on (t1.ID = t2.ID);

--Q2
--drop table txie.Totals
select * into txie.Totals from
(
select A.*,B.*,C.* from Text A
inner join 
ChronicConditions B
on A.tri_contactId = B.[tri_patientid]
inner join
Demographics C
on A.tri_contactId = C.contactid )AA

with cte as
(
    select [tri_contactId],[TextSentDate]
         , row_number() over (partition by [tri_contactId], [TextSentDate]
                              order by [TextSentDate] desc) as rn
    from txie.Totals
) 
delete from CTE where rn > 1;

Select *
    from txie.Totals
    inner join 
    (
        Select max([TextSentDate]) as LatestDate, tri_contactId
        from txie.Totals
        Group by tri_contactId
    ) SubMax 
    on txie.Totals.[TextSentDate] = SubMax.LatestDate
    and txie.Totals.tri_contactId = SubMax.tri_contactId 











