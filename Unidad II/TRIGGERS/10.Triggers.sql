use BDEJEMPLO2;
--REALIZAR UN TRIGGER QUE SE DISPARE CUANDO SE INSERTE UN PEDIDO
--CUANDO SE INSTERTE UN PEDIDO Y MODOFIQUE EL STOCK DEL PRODUCTO VENDIDO,
--VERIFICAR SI HAY SUFICIENTE STOCK SI NO SE CANCELA EL PEDIDO

select * from Pedidos
go
create or alter trigger tg_pedidos_insertar
on pedidos
after insert
as
begin
declare @existencia int
declare @fab char(3)
declare @prod char(5)
declare @cantidad int

select @fab = fab, @prod = producto,
@cantidad = Cantidad
from inserted

select @existencia = stock from Productos
where Id_fab = @fab and Id_producto = @prod;

if @existencia > (select cantidad from inserted)
begin
update Productos
set Stock = Stock - @cantidad
where Id_fab = @fab and
	  Id_producto = @prod;
	  end
	  else
	  begin 
		 raiserror('No hay suficiente stock para el pedido', 16,1)
		 rollback;
	  end
end;

select * from Pedidos
select max(Num_Pedido) from Pedidos
select * from Productos


declare @importe money
select @importe = (p.Cantidad * pr.Precio)
from Pedidos as p
inner join Productos as pr
on p.Fab = pr.Id_fab
and p.Producto = pr.Id_producto


select * from Pedidos
insert into Pedidos (Num_Pedido, Fecha_Pedido, Cliente, Rep, Fab, Producto, Cantidad, importe)
values (113071, getdate(), 2103, 106, 'ACI', '41001',77, @importe)

                                                                                                          
select * from  Productos
where Id_fab = 'ACI'
and Id_producto = '41001'
Aci, 41001 277

select * from Pedidos
where Num_Pedido = 113071



--Crear un  tringger  que cada vez que se elimine un pedido se debe de actulizar el stock
--de los productos con la cantidad eliminada

select * from Productos
go
create or alter trigger tg_pedidos_new_inser
on productos
after insert
as
begin
declare @num_pedido int
declare @rep int
declare @fab char(3)
declare @product char(5)
declare @cantidad int

