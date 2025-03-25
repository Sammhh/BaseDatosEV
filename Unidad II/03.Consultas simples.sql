
--Clausula where
--Operadores relacionales test de comparacion (<,>,=,<=,>=, != o <>)
select * from Customers;

--Filas duplicadas distinct(reducir nombres para que se vean solo uno)
select distinct Country from Customers
order by country

--Seleccionar el cliente BOLID

select CustomerID, CompanyName, City, country 
from Customers
where CustomerID = 'BOLID';

--Seleccionar los clientes, mostrando su identificador,
--nombre de la empresa, contacto, ciudad y pais
-- de alemania

select CustomerID as Identificador,
CompanyName, ContactName, Country, City 
from Customers
where Country = 'Germany' 

--Seleccionar todos los clientes que no sean de alemania

select CustomerID as Identificador,
CompanyName, ContactName, Country, City 
from Customers
where not Country = 'Germany' 

--Seleccionar todos los productos mostrando su nombre de producto
--categoria a la que pertenece, existencia, precio, pero solamente donde su precio sea mayor a 100 y mostar su costo de inventario 
 
 select ProductName as NombredeProducto,
 CategoryID as Categoria,
 UnitsInStock as existencia, 
 UnitPrice as Precio 
 from Products
 where UnitPrice >100 

 --seleccionar las ordenes de compra
 --mostrando la fecha de orden, la fechard e entrega, 
 --fecha de envio, el cliente a quien se vendio
 --de 1996

 select OrderDate as fechaOrden, 
 RequiredDate [fecha de requerimiento de entrega],
 ShippedDate 'fecha de envio', 
 CustomerID as Cliente
 from Orders
 where year (OrderDate) = '1996'


 --mostrar todas las ordenes de compra donde 
 --la cantidad de productos comprados sea mayor a 5
select * from [Order Details]
where Quantity >= 40

--muestr el nombre completo del empelado, su nuemero de empleado,
--fecha de nacimiento, la ciudad y fecha de contratacion y esta debe ser de aquellos
--esta debe ser de aquellos de 1993
--los resultados de sus encabezados deben ser mostrados en español

--campocalculado con concatenacion
select EmployeeID as 'Numero',
Concat (FirstName,  ' '  ,LastName, '_', Title) [Nombre Completo]
,BirthDate AS 'Fecha de Naciemiento',
HireDate AS 'Fecha de constratacion', City as 'Ciudad'
from Employees
where  year (HireDate) > 1993 

--MOSTRAR LOS EMPLEADOS QUE NOS SON DIRIJIDOS POR EL JEFE fuller
select EmployeeID as'IDEmpleado',
Concat (FirstName,  ' '  ,LastName, '_', Title) [Nombre Completo]
,BirthDate AS 'Fecha de Naciemiento',
city as 'ciudad', HireDate as 'Fecha de contratacion', ReportsTo as 'Jefe'
from Employees

where ReportsTo !=2


--Operadores Logicos (or, not, and)
--seleccionar los prodcutos que tengan un precio entre 10 y 50 dolares
select ProductName as 'Nombre', UnitPrice,
UnitsInStock as 'Existencia'
from Products
where UnitPrice>=10
and UnitPrice<=50;

--mostrar todos los pedidos realizados por clientes que no son enviados a Alemania

select * from Orders
where not ShipCountry = 'Germany' 

--seleccionar cleintes de mexico o estados unidos
select * from Customers

select Customers
from Customers = 'Mexico'
Where or Country = 'USA' 

--selelcionar los empleados que nacieron entre 1955 y 1958
--y que vivan en londres

select * from Employees
where(year(BirthDate)>=1955 and year(BirthDate)<=1958
and City ='London'

--Selccionar los pedidos con flete de peso (freight) mayor a 100,
--y enviados a francia o españa
select  OrderID, OrderDate, ShipCountry, Freigth
from Orders
Where Freight>100 and(ShipCountry = 'French' or ShipCountry='Spain')

--seleccionar las primerastop ordenes de compra
select top 5 * from Orders

select * from Orders

--seleccionar los productos con precio entre $10  y $50
--que no esten descontinuados y tengan mas de 20 unidades en stock
select * from Products

select ProductName, UnitPrice, UnitInStock, Discontinued
from Products
where UnitPrice>=10 and UnitPrice<=50
and Discontinued = 0
and UnitsInStock>20

--pedidos enviados a francia y alemania, pero con flete menos a 50

select * from Orders

--
select OrderID, ShipCountry, Freight
from Orders
where ShipCountry = 'Francia' or ShipCountry = 'Germany'
and Freight < 50

--clientes que no sean de mexico o usa y que tengan fax registrado
--el not hace la negacion o bien primero hace la evaluacion dentro y despues fura de este

select CompanyName, Country, City, Fax
from Customers
where not (Country='Mexico' or Country = 'USA')
and fax is not null

--Seleccionar pedidos con un flete mayor a 100
--enviados a brasil o argentina, pero no enviados por el transportista

--opcion 1
select concat (FirstName, '', LastName) as [Nombre Completo],
hiredate, city, country
from Employees
Where not (City= 'London' OR City = 'Seattle')
and year (HireDate) >= 1992

--opcion 2
select concat (FirstName, '', LastName) as [Nombre Completo],
hiredate, city, country
from Employees
Where not (City <> 'London' and City<>'Seattle')
and year (HireDate) >= 1992

--Clausula IN or
--selecionar los productos con categoria 1,3 o 5
select ProductName, CategoryID, UnitPrice
from Products
where CategoryID = 1 or CategoryID = 3 or CategoryID =5

--selecccionar rtodas las ordenes de la region RJ,
--Tachira que no tengan region asignada

select  ShipRegion, OrderID, OrderDate
from Orders
Where  ShipRegion in ('RJ', 'Táchira')
or ShipRegion is null

--seleccionar las ordenes que tengan cantidades de 12, 9 y 40 y descuento de 0.15 o 0.5

select OrderID, Quantity 
from [Order Details]
where Quantity in (12, 9, 40)
