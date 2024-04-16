--1).view and analyse the data:
		select * from dbo.['2018$']
		select * from dbo.['2019$']
		select * from dbo.['2020$']

--2).Combine all the data using 'UNION'
		select * from dbo.['2018$']
		union
		select * from dbo.['2019$']
		union
		select * from dbo.['2020$'])

--3).create a temporary table using 'WITH'
		
		with hotels as (
		select * from dbo.['2018$']
		union
		select * from dbo.['2019$']
		union
		select * from dbo.['2020$'])

		select * from hotels;

--4).if want to see revenue of the hotel by year but we dont have revenue column, instead we have adr,
--  stays_in_week_nights and stays_in_weekend_nights.
-- first we have to add week_nights and weekend_nights

		with hotels as (
		select * from dbo.['2018$']
		union
		select * from dbo.['2019$']
		union
		select * from dbo.['2020$'])

		select stays_in_week_nights+stays_in_weekend_nights from hotels;

-- Now multiply with 'Adr'(daily rate)

		with hotels as (
		select * from dbo.['2018$']
		union
		select * from dbo.['2019$']
		union
		select * from dbo.['2020$'])

		select (stays_in_week_nights+stays_in_weekend_nights)*adr as Revenue from hotels;

-- Also we can write above query like this

		with hotels as (
		select * from dbo.['2018$']
		union
		select * from dbo.['2019$']
		union
		select * from dbo.['2020$'])

		select
		arrival_date_year,
		sum((stays_in_week_nights+stays_in_weekend_nights)*adr) as Revenue 
		from hotels
		group by arrival_date_year;

--Also we can add one more column 'hotel'

		with hotels as (
		select * from dbo.['2018$']
		union
		select * from dbo.['2019$']
		union
		select * from dbo.['2020$'])

		select
		arrival_date_year,
		hotel,
		sum((stays_in_week_nights+stays_in_weekend_nights)*adr) as Revenue 
		from hotels
		group by arrival_date_year,hotel;

--we can round the number figure by using 'round'

			with hotels as (
		select * from dbo.['2018$']
		union
		select * from dbo.['2019$']
		union
		select * from dbo.['2020$'])

		select
		arrival_date_year,
		hotel,
		round(sum((stays_in_week_nights+stays_in_weekend_nights)*adr),2) as Revenue 
		from hotels
		group by arrival_date_year,hotel;

-- Also we have 2 more tables, lets take a look at it

		select*from dbo.market_segment$;
		select*from dbo.meal_cost$;

--join those two with previous tables

		with hotels as (
		select * from dbo.['2018$']
		union
		select * from dbo.['2019$']
		union
		select * from dbo.['2020$'])

		select * from hotels
		left join dbo.market_segment$
		on hotels.market_segment=market_segment$.market_segment
		left join dbo.meal_cost$
		on meal_cost$.meal=hotels.meal;