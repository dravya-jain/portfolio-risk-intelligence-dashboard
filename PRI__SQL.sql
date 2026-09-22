CREATE TABLE positions (
    portfolio_id INT,
    ticker VARCHAR(50),
    quantity INT,
    as_of_date DATE
);
    
CREATE TABLE prices (
    ticker VARCHAR(10) NOT NULL,
    price_date DATE NOT NULL,
    close_price DECIMAL(18 , 6 ) NOT NULL,
    PRIMARY KEY (ticker , price_date)
);
    
CREATE TABLE benchmark_prices (
    bench_id VARCHAR(10),
    price_date DATE,
    close_price DECIMAL(12 , 4 )
);

   
    
Insert into positions (portfolio_id, ticker, quantity, as_of_date)
Values
(1,'AVGO',1,'2026-07-31'),
(1,'V',1,'2026-07-31'),
(1,'AXP',1,'2026-07-31'),
(1,'AMD',1,'2026-07-31'),
(1,'MRVL',1,'2026-07-31'),
(1,'LLY',1,'2026-07-31');

Select *
from positions;

SET SQL_SAFE_UPDATES = 0;
SELECT* FROM prices
where ticker ='lly' 
 ;

SELECT 
    *
FROM
    prices
WHERE
    close_price IS NULL OR close_price <= 0;


SELECT 
    ticker, price_date, COUNT(*)
FROM
    prices
GROUP BY ticker , price_date
HAVING COUNT(*) > 1;

Create  view v_ticker_returns as
With price_lag as(
 select *, 
 lag(close_price) over(
 partition by ticker order by price_date) as prior_close_price
 from prices)
 Select *, (close_price / prior_close_price) - 1 as simple_return,
 LOG(close_price/prior_close_price) as log_return
 from price_lag
 where prior_close_price is not null;
 
 Create view v_benchmark_returns as
 With benchmark_lag as(
 select *, 
 lag(close_price) over(
 partition by bench_id order by price_date) as prior_close_price
 from benchmark_prices)
 Select *, (close_price / prior_close_price) - 1 as simple_return,
 LOG(close_price/prior_close_price) as log_return
 from benchmark_lag
 where prior_close_price is not null;

CREATE VIEW v_portfolio_returns AS
    SELECT 
        price_date, AVG(simple_return), AVG(log_return)
    FROM
        v_ticker_returns
    GROUP BY price_date
;
SET SQL_SAFE_UPDATES = 0;

UPDATE positions 
SET 
    as_of_date = '2024-08-01'
WHERE
    ticker = 'amd' OR ticker = 'AXP'
        OR ticker = 'V'
        OR ticker = 'MRVL'
        OR ticker = 'LLY'
        OR ticker = 'avgo';

select * from positions;


CREATE VIEW v_portfolio_vs_benchmark AS
    SELECT 
        p.price_date,
        p.`avg(simple_return)`,
        p.`avg(log_return)`,
        b.simple_return,
        b.log_return
    FROM
        v_portfolio_returns p
            JOIN
        v_benchmark_returns b ON p.price_date = b.price_date;
    
    
SELECT 
    *
FROM
    v_ticker_returns
ORDER BY price_date , ticker;
 
 SELECT 
    p.price_date, SUM(pos.quantity * p.close_price) AS port_mv
FROM
    prices p
        JOIN
    positions pos ON p.ticker = pos.ticker
GROUP BY p.price_date
ORDER BY p.price_date; 

Create view V_portfolio_PnL as
with cte as
( Select p.price_date, sum(pos.quantity * p.close_price) as port_mv
 from prices p
 join positions pos
 on p.ticker = pos.ticker
 group by p.price_date),
cte2 as(
 Select *, lag(port_mv) over(order by price_date) as previous_day_mv
 from cte)
 select *, port_mv - previous_day_mv as daily_pnl_usd,(port_mv/previous_day_mv) - 1 as portfolio_simple_return
 from cte2
 where previous_day_mv is not null;

 
 
 
 