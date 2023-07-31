-- CREATE DATABASE bigtechstocksdb;

USE bigtechstocksdb;

-- ALTER TABLE amazon
-- ADD COLUMN `Symbol` VARCHAR(64) NULL DEFAULT 'Amazon' FIRST;

-- ALTER TABLE apple 
-- ADD COLUMN `Symbol` VARCHAR(64) NULL DEFAULT 'Apple' FIRST;

-- ALTER TABLE google
-- ADD COLUMN `Symbol` VARCHAR(64) NULL DEFAULT 'Google' FIRST;

-- ALTER TABLE microsoft
-- ADD COLUMN `Symbol` VARCHAR(64) NULL DEFAULT 'Mircosoft' FIRST;
-- UPDATE microsoft set symbol = 'Microsoft' where symbol = 'Mircosoft';

drop view if exists stocks;
create view stocks as (
select * from amazon
union
select * from apple
union
select * from google
union
select * from microsoft);

select * from stocks;

-- What is the maximum opening price for a company's stocks for each year?
select symbol, year(`Date`) as year, max(open) as max_open from stocks
group by symbol, year;

-- What is the volume of stock recorded by year for each company from 2010-2022?
select symbol, `Date`, volume from stocks where symbol='google';
select symbol, year(`Date`) as year, sum(volume) as volumeYear from stocks
group by symbol, year;

-- Maximum Volume Month, Year for each company
(select symbol, monthname(`Date`) as month, year(`Date`) as year, volume as max_volume from stocks
where symbol='Amazon'
order by max_volume desc LIMIT 1)
union
(select symbol, monthname(`Date`) as month, year(`Date`) as year, volume as max_volume from stocks
where symbol='Apple'
order by max_volume desc LIMIT 1)
union
(select symbol, monthname(`Date`) as month, year(`Date`) as year, volume as max_volume from stocks
where symbol='Google'
order by max_volume desc LIMIT 1)
union
(select symbol, monthname(`Date`) as month, year(`Date`) as year, volume as max_volume from stocks
where symbol='Microsoft'
order by max_volume desc LIMIT 1);

-- In the year 2017,  what is the relationship between volume and opening prices for all companies?
-- How much the stocks would increase depending on the volume purchased at opening price
select symbol, year(`Date`) as year, month(`Date`) as month, day(`Date`) as day, open, volume from stocks
group by symbol, year, month, day, open, volume;

-- Calculate Avergae Volatility (Lower the Better)
-- Volatility is the rate at which the price of stock increases or decreses over a particular period
-- Higher volatility means higher risk and hleps investor estimate the fluctuations that may happen in the future
select symbol, round(avg(high - low), 2) as avg_volatility, dense_rank() over(order by avg(high-low) asc)
as ranking from stocks
group by symbol;

-- Calculate Fall in Stock Price
-- Lower the Better => Lower means there was less drawdown
-- Higer means there was more drawdown
-- Negatives means there was a gain in stocks

-- 2019-2021 => Represenets stocks drawdown during COVID years
select f.symbol, f.year2019 , f.month2019, f.close as close1, s.year2021, s.month2021, s.close as close2, round(((s.close - f.close) / f.close), 4) * 100 as 'drawdown (%)'
from
(select symbol, year(`Date`) as year2019, month(`Date`) as month2019, `close` from stocks where `Date` like '2019%' order by `Date` ASC LIMIT 4) as f
left join
(select symbol, year(`Date`) as year2021, month(`Date`) as month2021, `close` from stocks where `Date` like '2021%' order by `Date` DESC LIMIT 4) as s
on (f.symbol = s.symbol);

-- 2021-2022 => Represents stocks drawdown after COVID subided
select f.symbol, f.year2021 , f.month2021, f.close as close1, s.year2022, s.month2022, s.close as close2, round(((s.close - f.close) / f.close), 4) * 100 as 'drawdown (%)'
from
(select symbol, year(`Date`) as year2021, month(`Date`) as month2021, `close` from stocks where `Date` like '2019%' order by `Date` ASC LIMIT 4) as f
left join
(select symbol, year(`Date`) as year2022, month(`Date`) as month2022, `close` from stocks where `Date` like '2022%' order by `Date` DESC LIMIT 4) as s
on (f.symbol = s.symbol);

-- CAGR Calculation
-- Higher is better
set @number_years = round(timestampdiff(day, '2010-01-04', '2022-12-29') / 365, 3);

select @number_years;

select f.symbol, f.close2010, s.close2022,
round((power((s.close2022/f.close2010), (1 / @number_years))-1)*100, 4) as CAGR
from
(select symbol, close as close2010 from stocks
where `Date`='2010-01-04'
group by symbol, close) as f
left join
(select symbol, close as close2022 from stocks
where `Date`='2022-12-29'
group by symbol, close) as s
on (f.symbol = s.symbol);