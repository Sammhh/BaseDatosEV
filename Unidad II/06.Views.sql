--Nuevo views

--sintaxis
/*create view nombreVista
As
select columnas
from tablas
where condicion */
-----------------------------
--go es para
use Northwind
go
----------------------------
--crear tabla de vistas
create view VistaCategoriasTodas
AS
select CategoryID, CategoryName, [Description], picture
from Categories;
GO
------------------------------------
--crea si no esta realizada y la cambia
create or alter view VistaCategoriasTodas
AS
select CategoryID, CategoryName, [Description], picture
from Categories;
GO
--------------------
select * from VistaCategoriasTodas
where CategoryName = 'Beverages'
--------------------

--crear una vista que permita visualizar solamenete los clientes  de mexico y brasil
             --A una vista no le puedes agregar un order by-----
create or alter view VistaLatinos
as
select * from  Customers
where country in('Mexico', 'Brazil')

--ejemplo de order by---
select * from  VistaLatinos
order by 2 desc

------------------------------------------
select CompanyName as [Cliente], 
City as [Cuidad], country as [Pais]
from VistaLatinos
where City = 'Sao Paulo'
order by 2 desc

-----------------------------------------

select distinct vl.country from
Orders as o
inner join VistaLatinos as vl
on vl.CustomerID = o.CustomerID

--DATOS NULL---------------------------------------
select vl.country from
Orders as o
inner join VistaLatinos as vl
on vl.CustomerID = o.CustomerID

--CREAR una vista que contenga los datos de las ordenes
--los productos, categoriass de productos.

create or alter view [dbo].[vistaordenescompra]
as
select o.OrderID as [Numero de orden], o.OrderDate as [Fecha de orden], o.RequiredDate as [Fechad e requisicion], 
concat(e.FirstName,' ', e.LastName) as [Nombre empleado], cu.CompanyName as [Nombre del cliente], p.ProductName as [Nombre del producto], 
c.CategoryName as [Nombre de la categoria],od.UnitPrice as [Precio de venta], od.Quantity as [Cantidad vendida], 
(od.Quantity * od.UnitPrice) as [importe]
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID=p.ProductID
inner join Orders as o
on od.OrderID =o.OrderID
inner join Customers as cu
on cu.CustomerID = o.CustomerID
inner join Employees as e
on e.EmployeeID = o.EmployeeID
------------------------------------

Select * from vistaordenescompra

select count(distinct [numero orden]) as [Nuemero ordenes]
---------------------------
create schema rh

create table rh.tablarh (
id int primary key,
nombre varchar(50))

--vista horizontal
create or alter view rh.viewcategoriasproductos
as
select C.CategoryID, CategoryName, p.ProductID, p.ProductName
from
Categories as c
inner join Products as p
on c.CategoryID = P.CategoryID
-------------------------------------------------

select * from rh.viewcategoriasproductos
select sum(importe) as [importe total]
from vistaordenescompra
where year([Fecha de orden])between '1995' and '1996'
go
--se creo una vista dentro de otra vista
create or alter view vista_ordenes_1995_1996
as
select [Nombre del Cliente] as 'Nombre Cliente',
sum(importe) as [importe Total]
from vistaordenescompra
where year([Fecha de Orden])
between '1995' and '1996'  
group by [Nombre del Cliente]
having count(*)>2
----------------------------------