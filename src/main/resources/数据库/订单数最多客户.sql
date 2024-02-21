-- orders
-- | Column            | Type      |
-- |-------------------|-----------|
-- | order_number (PK) | int       |
-- | customer_number   | int       |
-- | order_date        | date      |
-- | required_date     | date      |
-- | shipped_date      | date      |
-- | status            | char(15)  |
-- | comment           | char(200) |

-- | order_number | customer_number | order_date | required_date | shipped_date | status | comment |
-- |--------------|-----------------|------------|---------------|--------------|--------|---------|
-- | 1            | 1               | 2017-04-09 | 2017-04-13    | 2017-04-12   | Closed |         |
-- | 2            | 2               | 2017-04-15 | 2017-04-20    | 2017-04-18   | Closed |         |
-- | 3            | 3               | 2017-04-16 | 2017-04-25    | 2017-04-20   | Closed |         |
-- | 4            | 3               | 2017-04-18 | 2017-04-28    | 2017-04-25   | Closed |         |


-- 注意并列第一的情况
-- SELECT
--     customer_number
-- FROM
--     orders
-- GROUP BY customer_number
-- ORDER BY COUNT(*) DESC
-- LIMIT 1 offset 0
-- ;
-- offset 表示跳过前面多少条数据。 默认0  limit x,y   x 表示偏移

-- 考虑到并列第一的情况
select customer_number from orders group by customer_number
having count(*)=(
    select count(*) as c
    from orders
    group by customer_number order by c desc limit 1)























