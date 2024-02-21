//Employee 表包含所有员工。Employee 表有三列：员工Id，公司名和薪水。
//
// +-----+------------+--------+
//|Id   | Company    | Salary |
//+-----+------------+--------+
//|1    | A          | 2341   |
//|2    | A          | 341    |
//|3    | A          | 15     |
//|4    | A          | 15314  |
//|5    | A          | 451    |
//|6    | A          | 513    |
//|7    | B          | 15     |
//|8    | B          | 13     |
//|9    | B          | 1154   |
//|10   | B          | 1345   |
//|11   | B          | 1221   |
//|12   | B          | 234    |
//|13   | C          | 2345   |
//|14   | C          | 2645   |
//|15   | C          | 2645   |
//|16   | C          | 2652   |
//|17   | C          | 65     |
//+-----+------------+--------+
//
//
// 请编写SQL查询来查找每个公司的薪水中位数。挑战点：你是否可以在不使用任何内置的SQL函数的情况下解决此问题。
//
// +-----+------------+--------+
//|Id   | Company    | Salary |
//+-----+------------+--------+
//|5    | A          | 451    |
//|6    | A          | 513    |
//|12   | B          | 234    |
//|9    | B          | 1154   |
//|14   | C          | 2645   |
//+-----+------------+--------+
//
// 👍 44 👎 0

-- 中位数（Median）又称中值，统计学中的专有名词，是按顺序排列的一组数据中居于中间位置的数，代表一个样
-- 本、种群或概率分布中的一个数值，其可将数值集合划分为相等的上下两部分。 对于有限的数集，可以通过把
-- 所有观察值高低排序后找出正中间的一个作为中位数。 如果观察值有偶数个，通常取最中间的两个数值的平均数
-- 作为中位数。

-- 对于一个 *奇数* 长度数组中的 *中位数*，大于这个数的数值个数等于小于这个数的数值个数。
-- 根据上述的定义，我们来找一下 `[1, 3, 2]` 中的中位数。首先 `1` 不是中位数，因为这个数组有三个元素，却有两个元素 `(3，2)` 大于 `1`。`3` 也不是中位数，因为有两个元素小于 `3`。对于最后一个 `2` 来说，大于 `2` 和 小于 `2` 的元素数量是相等的，因此 2 是当前数组的中位数。
-- 当数组长度为 *偶数*，且元素唯一时，中位数等于排序后 *中间两个数* 的平均值。对这两个数来说，大于当前数的数值个数跟小于当前数的数值个数绝对值之差为 1，恰好等于这个数出现的频率。
-- 总的来说，不管是数组长度是奇是偶，也不管元素是不是唯一，中位数出现的频率一定大于等于大于它的数和小于它的数的绝对值之差。这个规律是这道题的关键，可以通过下面这个搜索条件来过滤。

-- 方法一：核心在于 中位数出现的频率 >=  abs（大于它的数 - 小于它的数）
SELECT
    ANY_VALUE(employee.id), employee.company, employee.salary
FROM
    employee,
    employee alias
WHERE
        employee.company = alias.company
GROUP BY employee.company , employee.salary
HAVING SUM(CASE
               WHEN employee.salary = alias.salary THEN 1
               ELSE 0
    END) >= ABS(SUM(SIGN(employee.salary - alias.salary)))
ORDER BY ANY_VALUE(employee.id)
;

-- 方法二：
SELECT id, company, salary
FROM (SELECT *, RANK() OVER(PARTITION BY company ORDER BY salary, id) AS R1,
             RANK() OVER(PARTITION BY company ORDER BY salary DESC, id DESC) AS R2
      FROM employee) AS A
WHERE R1 BETWEEN R2 - 1 AND R2 + 1;




























