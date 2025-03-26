# Ejemplo Examen
use BDEJEMPLO2

--relizar un pedido
--validad que el pedido no exista
--validar que el cliente, el empleado y producto exista
--validar que la cantidad a vender tenga suficiente stock
--insertar el pedido y calcular el importe (multiplicamdo el precio del producto por la cantidad vendida)
--Actualizando el stock del producto(restando el stock menos la cantidad vendida)
```sql
--PASO 1
create or alter procedure spu_realizar_pedido

--PASO 2
@numPedido int, @cliente int,
@repre int, @fab char(3),
@producto  char(5),@cantidad int

--PASO 3
AS
Begin
--PASO 4
	if exists (select 1 from Pedidos where Num_Pedido = @numPedido)
	begin
	print 'El pedido ya existe'
	end
	--tercer requeriemiento
		if  not exists (select 1 from Clientes where Num_Cli = @cliente) or
			not exists (select 1 from Representantes where Num_Empl = @repre) or
			not exists (select 1 from Productos where Id_fab = @fab and Id_producto = @producto) 
	begin
		print 'Los datos no son validos'
		return
	end
	 if @cantidad<=0
	 begin
	 print 'la cantidad no puede ser 0 o negativo'
	 return;
	 end

	 declare @stockValido int
	 select @stockValido = Stock from Productos where Id_fab = @fab and Id_producto = @producto
	 
	 if @cantidad >@stockValido
	 begin
		print 'No hay suficiente stock'
		return;
		end

		declare @precio money
		declare @importe money

		select @precio=Precio from Productos where Id_fab = @fab and Id_producto = @producto
		set @importe=@cantidad * @precio
		insert into Pedidos
		values(@numPedido, getDate(), @cliente, @repre,@fab, @producto, @cantidad)
end;

--PASO 5
exec spu_realizar_pedido @numPedido = 113070, @cliente =2000,
@repre=106, @fab = 'REI',
@producto = '2A44L', @cantidad =20
-----------------------------------------------
exec spu_realizar_pedido @numPedido = 113070, @cliente =2000,
@repre=111, @fab = 'REI',
@producto = '2A44L', @cantidad =20
-----------------------------------------------
exec spu_realizar_pedido @numPedido = 113070, @cliente =2000,
@repre=106, @fab = 'REI',
@producto = '2A44L', @cantidad =20

--PASO 6
if not exists (select 1 from Clientes where Num_Cli =2000)
print ('ok')

```


