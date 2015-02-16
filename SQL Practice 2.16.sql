-- drop table cars;

create table cars (
   kind     text,
   make     text,
   model    text,
   priceUSD numeric

);


insert into cars(priceUSD, kind,           make,     model)
         values (98600.42, 'sports coup', 'Porche', '911 Carrera');
         
insert into cars(priceUSD, kind,           make,     model)         
         values (120007.42, 'sedan', 'BMW', '740il');

insert into cars(priceUSD, kind,           make,     model)         
         values (121007.42, 'sports coup', 'BMW', 'z7');

insert into cars(priceUSD, kind,           make,     model)         
         values (87007.42, 'sports coup/submarine', 'Lotus', 'Esprit');  

insert into cars(priceUSD, kind,           make,     model)         
         values (50500.80, 'sedan', 'Acura', 'TL');    

insert into cars(priceUSD, kind,           make,     model)         
         values (40000.36, 'SUV', 'Honda', 'Pilot');      

insert into cars(priceUSD, kind,           make,     model)         
         values (37800.45, 'sedan', 'Honda', 'Accord');                        

SELECT *
FROM cars
WHERE priceUSD >= 100000
  or model = 'Esprit'

delete from cars
where kind = 'sedan'

update cars
set priceUSD = priceUSD * 5
where make = 'Lotus'

SELECT *
FROM cars
WHERE priceUSD <= 60000.00
   and priceUSD >= 38000.00

delete from cars
where make = 'BMW'

update cars
set priceUSD = priceUSD * 3
where make = 'Honda'
