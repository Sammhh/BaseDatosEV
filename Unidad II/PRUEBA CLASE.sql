--EJERCICIO 1
select c.categoriaid, c.nombre, p.categoriaid
from Categorias as c
inner join productos as p
on p.categoriaid = c.categoriaid

--EJERCICIO 2
select c.categoriaid, c.nombre,
p.categoriaid, p.productoid, p.nombre
from Categorias as c
left join productos as p
on p.categoriaid = c.categoriaid

--EJERCICIO 3
select c.categoriaid, c.nombre,
p.categoriaid, p.productoid, p.nombre
from Productos as p
left join Categorias as c
on p.categoriaid = c.categoriaid

--Codigo Eliminar tabla
DBCC CHECKIDENT ('Productos', RESEED, 0);