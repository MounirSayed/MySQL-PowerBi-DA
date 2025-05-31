select * from walmart_sales ;

create table walmart_sales2
like walmart_sales;


insert walmart_sales2
select * from walmart_sales ;

select * from walmart_sales2 ;


----- converting holiday_falg from 1/0 to holiday or non- holiday to be better in visualizing ------
alter table walmart_sales2
modify column `Holiday_Flag`  text ;

update walmart_sales2
set Holiday_Flag = 'Non-holiday'
where Holiday_Flag = '0' ;

update walmart_sales2
set Holiday_Flag = 'holiday'
where Holiday_Flag = '1' ;


 
 ----- checking duplication -----
 
 select * ,
row_number () over( partition by `Date`, Weekly_Sales,Store,Holiday_Flag,Fuel_Price,Temperature,CPI,Unemployment ) as row_num
from walmart_sales2 ;

with duplicate_cte as ( select * ,
row_number () over( partition by `Date`, Weekly_Sales,Store,Holiday_Flag,Fuel_Price,Temperature,CPI,Unemployment ) as row_num
from walmart_sales2 
 )
select * from duplicate_cte
where row_num > 1 ;
 
----- No duplication ------

------ Check Null or Empty columns ------

SELECT * FROM walmart_sales2
where 'Date' is null 
or Weekly_Sales is null or Weekly_Sales =''
or Store is null or Store =''
or Holiday_Flag is null or Holiday_Flag = ''
or Fuel_Price is null or Fuel_Price = ''
or Temperature is null or Temperature = ''
or CPI is null or CPI = ''
or Unemployment is null or Unemployment = '' ;

----- No null or Empty columns -----


