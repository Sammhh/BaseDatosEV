--Funciones de cadena 
--las funciones de cadena permiten manipular tipos de datos
--como varchar nvarchar, char, nchar

use Northwind

--Funcion Len -> DEVUELVE LA LONGITUD DE UNA CADENA

--Declaracion de una variable
--------------------------------------------------------------
DECLARE @numero int;
SET @numero = 10;
print @numero
--------------------------------------------------------------
--Obtener el tama�o de la cadena almacenada en la variable Texto
DECLARE @texto varchar(50) = 'Hola, Mundo!';
select len(@texto) as [Longitud]--muestra el tama�o de texto
select RIGHT(@texto, 6)as Final
--LEFT eXtraen un numero especifico de caracteres desde el inicio de la cadena
select LEFT(@texto, 4)as Inicio

--RIGHT extrae un determinado nuemro de caracteres del final de la cadena
select RIGHT(@texto, 6)as Final

--SUBSTRING -> Extrae una parte de la cadena donde el primer parametro es la posicion inicial
-- y el tercer parametro el recorrido
select SUBSTRING (@texto, 7 ,5)

--FUNCION REPLACE -> remplaza una subcadena por otra
--(Cadena, cadena a remplazar, nuevo remplazo)
select REPLACE (@Texto, 'Mundo', 'Amigo')

--CHAR-INDEX
select CHARINDEX ('Hola', @texto)

--UPPER ->Convierte una cadena en mayusculas
select UPPER(@Texto) as Mayusculas

--poner un texto en mayusculas o bien solo una parte
DECLARE @texto2 varchar(50) = 'Hola, Mundo!';
select concat (LEFT(@texto2, 5),'',
UPPER(SUBSTRING (@texto2, 7 ,5)),
RIGHT(@texto2,1)
)as Textonuevo

--cambio a mayusculas de una tabla con datos especificados
UPDATE Customers
set CompanyName = Upper(CompanyName)
where Country in ('Mexico', 'Germany')
select * from Customers

--TRIM-> Quita espacios en blanco de una cadena
select trim(' test') as Result;



------------------------------------------------------------------------------------------------------

select CompanyName, len(CompanyName) as 'Numero de caracteres',
LEFT (CompanyName, 4) AS inicio,
RIGHT(CompanyName, 6) as Final
SUBSTRING(CompanyName, 7,4) as 'Subcadena'
from Customers

--Crear un store produre para seleccionar todos los clientes

create or alter procedure spu_mostrar_clientes
AS
begin
select * from Customers;
end;
go

--Ejecutar un store en transact spu