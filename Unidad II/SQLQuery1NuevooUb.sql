-- Creacion de la base de datos tienda1

-- Crea la base de datos tienda1
create database tienda1;

-- Usar la base de datos
use tienda1;


SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'categoria';

-- SQL-LDD
-- Crear la tabla categoria
create table categoria(
categoriaid int not null,
nombre varchar(20) not null,
constraint pk_categoria
primary key (categoriaid),
constraint unico_nombre
unique (nombre)
);

-- SQL-LMD
-- Agregar regristros a la tabla categoria
insert into categoria
values (1, 'Carnes frias');

insert into categoria(categoriaid,nombre)
values(2, 'linea blanca');

insert into categoria(nombre,categoriaid)
values ('vinos y licores',3);

insert into categoria
values  (4, 'Ropa'),
        (5, 'Dulces'),
        (6, 'Lacteos');
       
insert into categoria(nombre, categoriaid)
values ('Panaderia', 7),
        ('Zapateria', 8),
        ('Jugueteria', 9);
       
insert into categoria
values (10, 'Panaderia');
       
select * from categoria;

-- Tabla productos
create table producto1(
  productoid int not null,
  nombreProducto varchar(20) not null,
  descripcion varchar(80) null,
  precio money not null,
  existencia int not null,
  categoriaid int null,
  constraint pk_producto1
  primary key (productoid),
  constraint unico_descripcion
  unique(nombreProducto),
  constraint chk_precio
  check(precio>0.0 and precio<=1000),
  constraint chk_existencia
  check(existencia>0 and existencia<=200),
  constraint fk_categoria_producto1
  foreign key (categoriaid)
  references categoria(categoriaid)
)


select * from producto1

insert into producto1
values(1, 'Miguelito', 'Dulce sano para la lombriz', 34.5, 45, 5);

insert into producto1
values(2, 'tupsi pop', 'Dulce re-sano para el diente', 1000, 200, 5);

insert into producto1
values(3, 'Plancha', 'plancha facil el suit', 256.3, 134, 2);

select * from producto1
where categoriaid=5

select * from categoria

create table cliente(
clienteid int not null identity (1,1),
codigocliente varchar(15) not null,
nombre varchar(30) not null,
direccion varchar(100) not null,
telefono varchar (19) ,
constraint pk_cliente 
primary key (clienteid),
constraint unico_codigocliente
unique (codigocliente)
);
Create table detalleorden (
ordenfk int not null,
productofk int not null,
preciocompra money not null,
cantidad int not null,
constraint pk_detalleorden
primary key (ordenfk, productofk),
constraint chk_preciocompra
check(preciocompra>0.0 and preciocompra<=200),
constraint chk_cantidad
check(cantidad>0),
constraint fk_detalleorden_producto
foreign key(productofk)
references producto1(productoid)
);

create table ordencompra (
ordenid int not null identity(1,1),
fechacompra date not null,
cliente int not null,
constraint pk_ordencompra
primary key (ordenid),
constraint fk_ordencompra_cliente
foreign key (cliente)
references cliente (clienteid)
);

alter table detalleorden
add constraint fk_detalleorden_ordencompra
foreign key (ordenfk)
references ordencompra(ordenid);






--TEMA 2


--Lenguaje SQL-LMD (insert, update, delete, select- CRUD)
--Consultas Simples

use Northwind;
--	Mostrar todos los cliente, proveedores, categorias, productos con todas las columnas de datos de la empresa

select*from Customers;
select *from Employees;
select*from Orders;
select*from Suppliers;
select*from Products;
select*from Categories;
select*from [Order Details];
select*from Shippers;

--Proyeccion
select ProductID, ProductName, UnitPrice, UnitsInStock 
from products;

--seleccionar el numero de empleado, su primer nombre, su cargo, ciudad y pais. 
select EmployeeID, FirstName, Title, Country, City 
from employees;

--Alias de columna 

--En base a la consulta anterior, visualizar es employeeid
-- como numero de empleados, firstname como primer nombre, 
--title como cargo, city como ciudad, country como pais

select EmployeeID as 'Numero Empleado',
FirstName as primernombre,
Title 'cargo',
city as ciudad,
country as pais 
from employees;

select EmployeeID as [Numero Empleado],
FirstName as primernombre,
Title 'cargo',
city as ciudad,
country as pais 
from employees;

-- Campos calculados
--selecccionar el importe de cada uno de los productos
--vendidos en una orden 

select*, (UnitPrice * Quantity) as importe from [Order Details]

--selecionar las fechas de orden, a�o, mes y dia, el cliente 
--que las ordeno y el empleado que la realizo

select OrderDate,year(OrderDate) as a�o , month(OrderDate) as mes , day (OrderDate) as dia,
CustomerID, EmployeeID from Orders;



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
--los resultados de sus encabezados deben ser mostrados en espa�ol

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
--y enviados a francia o espa�a
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
Where  ShipRegion in ('RJ', 'T�chira')
or ShipRegion is null

--seleccionar las ordenes que tengan cantidades de 12, 9 y 40 y descuento de 0.15 o 0.5

select OrderID, Quantity 
from [Order Details]
where Quantity in (12, 9, 40)


--Clausula between (simpre va el where)

--between  avlorInicial and ValorFianl
--mostrar los productos con precio entre 10 y 50
--opcion 1
SELECT * FROM Products
where UnitPrice >= 10 and UnitPrice<=50;
--opcion 2
SELECT * FROM Products
where UnitPrice between 10 and 50

--selecionar todos los pedidos realizados, entre el 1ero de enero y el 30 de junio de 1997
select * From Orders

select * From Orders
where OrderDate>='1997-01-01' and OrderDate<= '1997-06-01'

select * From Orders 
where OrderDate between '1997-01-01' and '1997-06-01'

--seleccionar todos loe empleadoes entre 1992 y 1994 que trabajan en londres
select * From Employees
Where year (HireDate)>=1992 and
	  year (HireDate)>=1994 and 
	  City = 'London'

--pedidos con flete (freigh) entre 50 y 200 enviados a alemania
select * From Orders

select ShipCountry as[Pais de Entrega],
Freight as [Peso],
OrderID as[Numero de Orden]
from Orders 
Where Freight>=50 and Freight<=200
and (ShipCountry = 'France' or ShipCountry = 'Germany')

--SELECCIIONAR TODOS LOS PRODUCTOS QUE TENGA UN PRECIO ENTRE 5 Y 20 DOLARES
--O QUE SEAN DE LA CATAEGORIA 1, 2 0 3
select * From Products 
where (UnitPrice between 5 and 20)and CategoryID in (1, 2, 3)

--EMPLEADOS CON NUMERO DE TRABAJADOR ENTRE 3 Y 7 QUE NO TRABAJAN EN LONDRES NI SEATTLE
select * From Employees
--campo calculado
select EmployeeID as[Numero de Empleado],
concat (FirstName, '' ,LastName) as [Nombre completo],
city as [ciudad]
from Employees
where EmployeeID>=3 and EmployeeID<=7
and (City<>'London' and City<>'Seattle')

--CLAUSULA LIKE
--Patrones:
--1) %  Representa cero o mas caracteres en el patron de busqueda 
--2) _  Representa un caracter en un caracter en el patron de busqueda
--3) [] Se utiliza para defnir un conjuntode caracteres, buscando cualquiera de ellos en la posicion especifica
--4)[^] (acento ciculflejo) Se utiliza para buscar caracteres que no estan, dentro del conjunto especifico

--BUSACR LOS PRODUCTOS QUE EMPIECEN CON CHA
select * from Products
where ProductName like 'Cha%'
and UnitPrice =  18

--buscar todas los productos que terminen con e
select * from Products
where ProductName like  '%e'

--selccionar todos los clientes cuyo nombre la empresa  continen la palabra "co" en cualquier parte
select * from Customers
where CompanyName like '%co%'

--seleccinar empleados cuyo nombre comience con a y tenga exacatamente 5 caracteres
select FirstName, LastName
from Employees
where FirstName like 'A_____'

select * from Products
where ProductName like '[A-M]%'

--SELECCIONAR TODOS LOS PRODUCTOS QUE NO COMIENCEN CON A o B
select * from Products
where ProductName like '[^A-M]%'

--seleccionar todo los productos donde el nombre
--que comience con a pero no contenga la E
Select * from Products
where ProductName like 'a[^e]%'

Select ProductID, ProductName, UnitPrice as 'Precio', UnitsInStock
from Products
order by 'Precio' desc

--seleccionar los cleintes ordenados por el pais y dentro 
--por ciudad

--OPCION 1
select CustomerID, Country, City
from Customers
where Country in ('Brazil','Germany')
order by country asc, city desc

--OPCION 2
select CustomerID, Country, City, Region
from Customers
where (Country = 'Brazil'or Country ='Germany')
and Region is not null
order by country asc, city desc




--Ejercicios TAREA

 --Productos con categor�a 1, 3 o 5
SELECT * FROM Products
WHERE CategoryID IN (1, 3, 5);

--Clientes de M�xico, Brasil o Argentina
SELECT * FROM

--Pedidos enviados por los transportistas 1, 2 o 3 y con flete mayor a 50


--Empleados que trabajan en Londres, Seattle o Buenos Aires


--Pedidos de clientes en Francia o Alemania, pero con un flete menor a 100


--Productos con categor�a 2, 4 o 6 y que NO est�n descontinuados


--Clientes que NO son de Alemania, Reino Unido ni Canad�


--Pedidos enviados por transportistas 2 o 3, pero que NO sean a USA ni Canad�


--Empleados que trabajan en 'London' o 'Seattle' y fueron contratados despu�s de 1995


--Productos de categor�as 1, 3 o 5 con stock mayor a 50 y que NO est�n descontinuados




--UNIDAD 2

--consutas de agregado
--nota solo devuelven un solo registro
--sum, avg, count (*), max y min

--cuantos clientes tengo


select + * from Orders
select count(*)
select count(ShipRegion)from Orders

select * from Products

--selecciona el precio mas bajo de los productos
select min(UnitPrice), max (UnitPrice),
avg(UnitsInStock)
from Products

--selccionar cuantos pedidos existen
select count (*) as [Numero de Pedidos]
from orders


--calcula el total de dinero vendido
select sum (UnitPrice * Quantity)
from [Order Details]

select sum (UnitPrice * Quantity - (UnitPrice * Quantity * Discount) ) as Total
from [Order Details]

--cualcula el total de unidades en stock de todos los prodcutos
select sum (UnitsInStock) as 'Total Stock'
from Products 

--seleccionar el total de dinero que se gano en el ultimo trimestre de
--1996
select *  from Products [Order Details]

--TEMA 3

select count(CategoryID), Count (*)
from Products

--opcion 2
select count(CategoryID), Count (*) as 'Numero de Pproducutos'
from Products
group by CategoryID



--joins
select Categories.CategoryName,
count(*)
from
Categories
inner join Products as p
on Categories.CategoryID = p.CategoryID
group by Categories.CategoryName

--calcular el precio promedio de los productos por cada categoria
select CategoryID, AVG (UnitPrice) as 'Precio Promedio'
from Products
group by CategoryID

--selcciona el numero de pedidos realizados por cada empleado por el ultimo trimestre de 1996
select * from Orders

select EmployeeID, count(*) as 'Numero de Pedidos'
from Orders
group by EmployeeID

Select * from Orders
where OrderDate between '1996-10-01' and '1996-12-31'



--Selecciona la suma total de unidsades vendidas por cada producto
--opcion 1
select top 5 ProductID,
sum (Quantity) as 'Numero de Productos Vendidos'
from [Order Details]
group by ProductID
order by 2 desc

--opcion 2 especifica detalles mas especificos
select orderid, ProductID,
sum (Quantity) as 'Numero de Productos Vendidos'
from [Order Details]
group by OrderID, ProductID
order by 2 desc


--seleccionar el numero de productos por las categorias pero solo aquellos que tengan mas de 10 productos
--where filtr filas
--having filtra grupos de las listas
--distinct lista de categorias

--Paso 2
select CategoryID, UnitsInStock
from Products
where CategoryID in (2, 4, 8)
order by CategoryID

--Paso 3 agrupacion
select CategoryID,sum (UnitsInStock)
from Products
where CategoryID in (2, 4, 8)
group by CategoryID
order by CategoryID

--paso 4 having
select CategoryID,sum (UnitsInStock)
from Products
where CategoryID in (2, 4, 8)
group by CategoryID
having count (*)>10
order by CategoryID

--Listar las ordenes agrupadas por empleado, pero que solo mustre aquellos
-- que hayan gestionado mas de 10 pedidos

select distinct * from Orders

select EmployeeID, CustomerID
from Orders
group by EmployeeID
having count (*)>10
order by OrderID