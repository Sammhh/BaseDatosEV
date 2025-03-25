#creacion de la base de datos tienda 1
#Crea la base de datos tienda 1
create database tienda1;

#Utilizar un abase de datos
use tienda1;
#SQL #LDD

create table categoria(
categoriaid int not null,
nombre varchar(20) not null,
constraint pk_categoria
primary key(categoriaid),
constraint unico_nombre
unique(nombre)
);

#SQL LMD
#Agregar registros a la tabla categoria
insert into categoria
values (1, 'Carnes frias');

insert into categoria (categoriaid, nombre)
values(2, 'Linea blanca');

insert into categoria (categoriaid, nombre)
values(3, 'Vinos y Licores');

insert  into categoria
values (4, 'Ropa'),
       (5, 'Dulces'),
	   (6, 'Lacteos');

insert into categoria(nombre, categoriaid)
values ('Pananderia', 7),
       ('Zapateria', 8),
	   ('Jugueteria', 9);

insert into  categoria
values(10, 'Panaderia');

select * from categoria;

