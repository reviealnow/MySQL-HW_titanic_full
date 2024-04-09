use  my_titanic;
select * from passengers;
select pname,sex from full_passengers where pname like '% Andersson%';

show warnings;

-- 1.查詢各性別乘客的總人數，請顯示在sex與gender_counts這兩個欄位 ok
select sex, count(sex) gender_counts from full_passengers group by sex;

-- 2.查詢第591至第883名乘客的id與姓名資料 ok
select id, pname 姓名資料 from full_passengers where id between 591 and 593;

-- 3.	請找出所有的Anders & Alfrida Andersson家成員以及存活狀態 ok
-- <<提示一>>共7人
-- <<提示二>>同一家人會一起上下船
select pname as Andersson家, survived as 存活狀態 from full_passengers where pname like '%Andersson%' and ticket = '347082' ;
 
-- 4.承上題，已知Afrida還有一個已婚的妹妹叫做Anna，請找出Anna與其丈夫小孩一家三口的全部資料 ok
-- <<提示一>>已結婚的女性姓名欄中仍會註記娘家姓氏
-- <<提示二>>觀察一家人可能會有的資料特徵
select * from full_passengers where pname like '%Brogren%';
select * from full_passengers where ticket = 347080;

-- 5.找出所有名字是Leonard的男性乘客，顯示id, pclass, pname ok
-- <<提示>>共7位，不是8位
select * from full_passengers where pname like '%Leonard%' and sex ='male';
select id, pclass, pname from full_passengers where pname like '% Leonard%' and sex ='male';

-- 6.	查詢所有乘客持有的票券中，最多人持有的那一種ticket，回傳票券名稱(ticket)與持有人數(ticket_count)兩個欄位
-- <<提示>>共11人持有
select * from full_passengers;
select ticket, count(*) as ticket_count from full_passengers group by ticket order by ticket_count desc;
select ticket, count(*) as ticket_count from full_passengers group by ticket order by ticket_count desc limit 1;
select ticket as '票券名稱(ticket)', count(*) as '持有人數(ticket_count)' from full_passengers where ticket ='CA. 2343';
 
-- CA. 2343 
show warnings;

-- 7.	找出二等客艙以及三等客艙中所有男性乘客的平均年齡 ok
-- <<提示>>小心邏輯運算子的使用
select avg(age) from full_passengers where pclass =2 and sex ='male';
select avg(age) from full_passengers where pclass =3 and sex ='male';

select avg(age) as 平均年齡
from full_passengers
where pclass in ('2', '3') and sex = 'male';

-- 8.	列出所有登船點的登船人數與百分比，僅列出有明確登船地點的資料即可 ok
-- <<提示一>>3列3欄，3欄位名稱分別為登船點、登船人數、登船點佔百分比
-- <<提示二>>select round(3.14159, 2);
select * from full_passengers ;
select count(embarked), embarked, 
case
	when embarked ='S' then 'Southampton'
    when embarked ='Q' then 'Queenstown'
    when embarked ='C' then 'Cherbourg'
    else 'unknown'
    end 登船點
from full_passengers
group by embarked;
-- SELECT 
--     embarked as '登船點', 
--     count(*) as '登船人數'
-- from full_passengers 
-- group by embarked
-- ;
select 
    embarked as '登船點', 
    count(*) as '登船人數', 
    concat(round(count(*) * 100.0 / (select count(*) from full_passengers where embarked is not null), 2)) as '登船點佔百分比'
from full_passengers
where embarked is not null
group by embarked 
order by embarked desc limit 3;


