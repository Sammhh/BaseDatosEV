--Store procedure con parametros de salida 

create or alter proc spu_obtener_numero_clientes 
@customerid nchar(5), --parametro de entrada
@totalCustomers int output --parametro salida 
as
begin 
select @totalCustomers=count(*) from Customers
where CustomerID = @customerid;
end;
GO

declare @numero int;
exec  spu_obtener_numero_clientes @customerid= 'ANATR'
                                  @totalCustomers= @numero output;
print @numero;
go

--Crear un sp que permita saber si un alumno aprobo o reprobo 

create or alter proc spu_comparar_calificacion 
@calif decimal(10,2) --parametro de entrada 
as 
begin 
   if @calif >0 and @calif<=10
   begin 
         if @calif>=8
         print 'La calificacion es aprovatoria' 
         else 
         print ' La calificaccion es reprobatoria'  
  end
  else 
       print 'Calificacion no valida'
  end ;
  GO


  exec spu_comparar_calificacion @calif =11
  go

  --Crear un sp que permita verificar si un cliente existe antes de devolver su informacion 

  create or alter procedure spu_obtener_cliente_siexiste
  @numeroCliente nchar(5)
  as 
  begin
      if exists (select 1 from customers where CustomerID= @numeroCliente)
	  select * from Customers where CustomerID = @numeroCliente;
	  else 
	    print 'El cliente no existe'
	end; 	
  go 

  exec spu_obtener_cliente_siexiste @numeroCliente= 'Moises'

  --Crear un store procedure que permita crear un cliente, 
  --pero se debe verificar que no exista 
  --------------------------------------------------------------------
--STORE
  select * from Customers
  create or alter procedure spu_agregar_cliente_try_catch
  @id nchar (5),
  @nombre  nvarchar(40),
  @city  nvarchar(40) ='San Miguel'
  as 
  begin
  ---------------------------------------------------------
  begin try
  insert into Customers(customerid,companyname)
  values(@id, @nombre);
  print('Cliente insertado exitosamente');
  end try
  begin catch
  print('El cliente ya existe')
  end catch
  ---------------------------------------------------------------
  if exists (select 1 from Customers where CustomerID =@id)
  begin 
  print('El cleinte ya existe')
  return 1
  end
  ----------------------------------------------------------------
  insert into Customers(customerid,companyname)
  values(@id, @nombre);
  print('Cliente insertado exitosamente');
  return 0;
  end;
  go

  exec spu_agregar_cliente 'A1FKD', ' viejaBarbie'
 
 ---------------------------------------------------------------
--Manejo de ciclos en Stores procedures-----------------------------------

--Imprimir el numero de veces que indique el usuario------------------------

create or alter procedure spu_imprimir
@numero int
as
begin
if @numero <=0    --si lleva mas de una linea va begin
print('El nuemero no puede se 0 o negativo')
return
end

declare @i int --variable
SET @i = 1
while(@i<=@numero)
begin
	print concat('Numero' + @i)
	set @i = @i + 1
	end

end;
go
exec spu_imprimir 10
----------------------------------------------------