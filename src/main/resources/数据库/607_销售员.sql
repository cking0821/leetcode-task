drop table salesperson if exists;
create table salesperson
(
    `sales_id`     int,
    `name`     string,
    `salary`     double,
    `commission_rate`     double,
    `hire_date`     string
)
;

insert into table salesperson(sales_id,name,salary,commission_rate,hire_date)
values
(1,'John',100000,6,'4/1/2006'),
(2,'Amy',120000,5,'5/1/2010'),
(3,'Mark',65000,12,'12/25/2008'),
(4,'Pam',25000,25,'1/1/2005'),
(5,'Alex',50000,10,'2/3/2007')
;


drop table company if exists;
create table company
(
    `com_id`     int,
    `name`     string,
    `city`     string
)
;

insert into table company(com_id,name,city)
values
(1,'RED','Boston'),
(2,'ORANGE','New York'),
(3,'YELLOW','Boston'),
(4,'GREEN','Austin')
;



drop table orders if exists;
create table orders
(
    `order_id`     int,
    `order_date`     string,
    `com_id`     int,
    `sales_id`   int,
    `amount`     double
)
;

insert into table orders(order_id,order_date,com_id,sales_id,amount)
values
(1,'1/1/2014',3,4,100000),
(2,'2/1/2014',4,5,5000),
(3,'3/1/2014',1,1,50000),
(4,'4/1/2014',1,4,25000)

;



select name from salesperson  where sales_id not in (
select a.sales_id from orders a join company b on a.com_id = b.com_id
where b.name = "RED"
)

