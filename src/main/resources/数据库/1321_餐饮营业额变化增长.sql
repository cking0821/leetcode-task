

-- customer
-- customer_id | name         | visited_on   | amount      |

-- 写一条 SQL 查询计算以 7 天（某日期 + 该日期前的 6 天）为一个时间段的顾客消费平均值
-- 查询结果格式的例子如下：
-- 查询结果按 visited_on 排序
-- average_amount 要 保留两位小数，日期数据的格式为 ('YYYY-MM-DD')
create table Customer
(
    `customer_id`     string comment 'customer_id',
    `name`         string comment 'name',
    `visited_on`   string comment 'visited_on',
    `amount`   double comment 'amount'
)
;
insert into table Customer(customer_id,name,visited_on,amount)
values ('1','Jhon','2019-01-01',100),
       ('2','Daniel','2019-01-02',110),
       ('3','Jade','2019-01-03',120),
       ('4','Khaled','2019-01-04',130),
       ('5','Winston','2019-01-05',110),
       ('6','Elvis','2019-01-06',140),
       ('7','Anna','2019-01-07',150),
       ('8','Maria','2019-01-08',80),
       ('9','Jaze','2019-01-09',110),
       ('1','Jhon','2019-01-10',130),
       ('3','Jade','2019-01-10',150)
;
select visited_on,total,round(avg(total) over(order by visited_on asc rows between 6 preceding and current row ),2) as avg_value
from (
         select visited_on,sum(amount) as total from Customer group by visited_on
     )t
order by visited_on asc






