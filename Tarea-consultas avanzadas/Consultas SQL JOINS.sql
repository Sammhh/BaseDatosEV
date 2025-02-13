--seleccionar todas las categorias de productos
--iner join
use Northwind


--opcion 1

select c.CategoryID, CategoryName, ProductName, UnitsInStock, UnitPrice
from Categories as c
inner join
Products as p
on c.CategoryID = p.CategoryID;

--opcion 2 join
select c.CategoryID as [Numero de Categoria],
CategoryName as 'Nombre Categoria', ProductName as 'Nombre de producto',
UnitsInStock as 'Existencia',
UnitPrice as 'Precio'
from Categories as c
inner join
Products as p
on c.CategoryID = p.CategoryID;

--seleccionar los productos de la categoria brevages y condiments donde la existencia
--esta entre 18 y 30

Select *
from Products as p
join Categories as ca
on p.CategoryID =ca.CategoryID
where (ca.CategoryName = 'beverages'or ca.CategoryName = 'Condiments')
and p.UnitsInStock>=18 and p.UnitsInStock<=30


Select *
from Products as p
join Categories as ca
on p.CategoryID =ca.CategoryID
where ca.CategoryName in ('beverages', 'Condiments')
and p.UnitsInStock between 18 and 30

--seeleccionar los productos y sus importes realizados de marzo a junio
--de 1996, mostrando la fecha de la orden, el id del productco y el importe

select o.orderID, O.orderdate, od.ProductID
from Orders as o
inner join [Order Details] as od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-07-01' and '1996-10-30'


--mostrar el formato de fechas
select getdate()

--mostrar el importe total de ventas de la consulta anterior
select sum(od.Quantity * od.UnitPrice)
select concat('$', ' ')sum(od.Quantity * od.Unit)
from Orders as o
inner join [Order Details] as od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-07-01' and '1996-10-30'

--Consultas basicas con inner join

--1.Obtener los nombres de los clietes y los paises a los
--que se enviaron sus pedidos


select c.CompanyName o ShipCountry
from Orders as o
inner join Customers as c
on c.CustomersID = o.CustomersID
from 


--2.Obtener los productos y sus respectivos provedores
SELECT p.ProductName AS 'Nombre del producto', s.CompanyName
FROM Products AS p
INNER JOIN Suppliers AS s
ON p.SupplierID = s.SupplierID;

--3.Obtener los pedidos y los empleados que slo gestionaron
select o.OrderID,concat(e.Title, ' - ', e.FirstName,'',e.LastName) as 'Nombre'
from Orders as o
inner join Employees as e
on o.EmployeeID = e. EmployeeID

--4.Listar los productos juntos con sus precios y la categoria a la que pertenecen
select p.ProductName AS 'Nombre del producto', 
       p.UnitPrice AS 'Precio', 
       c.CategoryName AS 'Categoría'
FROM Products AS p
INNER JOIN Categories AS c
ON p.CategoryID = c.CategoryID


--5.Obtenenr el nombre del cliente, el numero de orden y la fecha de orden
select  CustomerID, OrderID, OrderDate
from Orders as o


--6.Listar las ordenes mostrando el numero de orden, el nombre del producto y la cantidad
--que se vendio

SELECT o.OrderID AS 'Número de Orden',
       p.ProductName AS 'Nombre del Producto',
       od.Quantity AS 'Cantidad Vendida'
FROM Orders AS o
INNER JOIN OrderDetails AS od
ON o.OrderID = od.OrderID
INNER JOIN Products AS p
ON od.ProductID = p.ProductID;


select concat(e1.FirstName, ' ',e1.LastName) as [Nombre],
concat (j1.FirstName, ' ', j1.LastName) as [Jefe]
from Employees as e1
inner join Employees as j1
ON e1.ReportsTo = J1.EmployeeID

select FirstName, ReportsTo
from Employees

--8.Listar los pedidos y el nombre de la empresa de trasnporte 

select * from
orders as o
inner join
Shippers as s
on o.ShipVia = s.ShipperID

-- consultas en inner join intermedias

--9.obtener la cantidad total de productos vendidos por categoria
select c.CategoryName as 'Nombre Categoria',
sum(Quantity) as 'Productos Vendidos'
from Categories as c
inner join Products AS P
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
group by c.CategoryName
ORDER BY C.CategoryName

--10.obtener el total de ventas por empleado

select e.FirstName, count (o.OrderID)
from Orders as o
inner join Employees as e
on o.EmployeeID =e.EmployeeID
inner join [Order Details] as od
on od.OrderID = o.OrderID
where e.EmployeeID = 1
group by e.FirstName




select count(*)
from Orders as o
where EmployeeID = 1


