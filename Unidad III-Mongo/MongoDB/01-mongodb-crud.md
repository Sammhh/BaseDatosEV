# MongoDB Crud
## Crear una base de datos

**Solo se crea si contiene por lo menos una coleccion**

```json
use basededatos
```

# Crear una coleccion
`use db1
db.createCollection('Empleado')`

## Mostrar collections
`Show collections`

## Inserccion de un documento
db.Empleado.insertOne(
    {
    nombre:'Soyla',
    apellido:'Vaca',
    edad:32,
    ciudad:'San Miguel de las piedras'
    }
)

## Insercion de un documento mas complejo con array
```json
db.Empleado.insertOne({
nombre: 'Ivan', 
apellido: 'Baltazar',
apellido2: 'Rodriguez',
aficiones: ['Cerveza', 'Canabis','Crico', 'Mentir']
})
```

**Eliminar una coleccion**
db.colection.drop()

_ejemplo_
```json
db.empleado.drop()
```
##  Insercion de documentos mas complejos con anidados

```json
db.alumnos.insertOne(
{
nombre: 'Samantha',
apellido:'Hernandez',
apellido2:'Hernandez',
edad: '20',
estudios:['Ingenieria Nnegcios Digitales'
],
experiencia:{
    lenguaje:'',
    sgb:'',
    anios_esperiencia: 20
}
}
)
```
```json
db.alumnos.insertOne({
    _id:3,
    nombre:'Sergio',
    apellido: 'Ramos',
    equipo: 'Monterrey',
    aficiones:['Dinero','Hombres', 'Fiesta'],
    talentos:{
        futbol:true,
       bañarse: false

    }
})

```
## Insertar multiples Documentos
```json
//arreglo de documentos
db.alumnos.insertMany()
[
    {
_id:12,
nombre:'Oswaldo',
apellido:'Venado',
edad: 20,
descripcion:'Es un quejumbroso'
    },
    {
nombre:'Maritza',
apellido:'Rechicken',
edad:20,
habilidades:[ 'Ser vibora', 'Ilusionar', 'Caguamear'],
direccion: {
   calle: 'El infierno',
   numero: 666
},
esposos:[
    {
        nombre:'Joshua',
        edad:20,
        pension:-34,
        hijos:['Ivan', 'Jose']
    },
    {
        nombre: 'Lana',
        edad: 15,
        pension: 70,
        complaciente:true
         }
      ]  
       }
     ]
 )
 
```

## Busquedas, condiciones simples de igualdad mertodo find()
1. Seleccionar todos los documentos de la coleccion
    ```json
db.libros.find({})
    ```
2. Seleccionar todos los docuemtos de la editorial biblio

 ```json
db.libros.find({editorial:'Biblio'})
    ```
3. Mostrar todos los docuementos que el precio sea 25.
 ```json
db.libros.find({precio:25})
```
4.Seleccionar todos los docuementos donde el titulo sea 'json para todos'.
 ```json
db.libros.find({titulo:'JSON para todos'})
```


# Operadores de comparacion
[Operadores de comparacion](https://www.mongodb.com/docs/manual/reference/operator/query/)

![Operadores de Comapracion](./img/operadores-Relacionales.png)

1. Mostrar todos los documentos, donde el precio sea mayor a 25.
```json
db.libros.find({precio:{$gt:25}})
```

2. Mostra los documentos donde el precio sea 25.
```json
db.libros.find({precio:{$eq:25}})
```

3. Mostrar los documentos cuya cantidad sea menor a 5.
```json
db.libros.find({cantidad:{$lt:5}})
```
4. Mostrar los docuementos que pertenecer a la editorial Biblia o PLaneta.
```json
db.libros.find
(
{
    editorial:
    {
    $in: ['Biblia', 'Planeta' ]
    }
}
)
```
5. Mostrar todos los documentos que cuesten 20 o 25.
```json
db.libros.find
({
precio:
{
    $in:{20, 25}
}
})
```

6. Recuperar todos los documentos que no cuesten 20 o 25.
```json
db.libros.find
({
  precio:
{
    $nin:{20, 25}
}  
})
```
# instruccion FindOne
7. Recuperar solo una fila(Devuelve el primer elemento que cumple la condicion)
```json
db.libros.findOne
({
precio:
{
    $in:[20, 25]
}
})
```
# Operadores Logicos
[Operadores Logicos](https://www.mongodb.com/docs/manual/reference/operator/query-logical/)

##Operador AND
-Dos posibles opciones
1.0 La simple, mediante condicines separadas por comas
    - bd.libros.find({Condicion1, condicion2......})->Asume que es una ADN
1.1 Usando el operador $and
    - db.libros.find({ $and: [ {condicion1}, {condicion1}]})

1. Mostrar todos aquellos libros que cuesten mas de 25 y cuya cantidad sea inferior a 15

# Ejemplo 1
```json
db.libros.find
(
{
    precio:{$gt:25},
    cantidad:{$lt:15}
}
)
```
# Ejemplo 2
```json
db.libros.find
(
{
    $and:[
   {precio:{$gt:25}}
{}
    ]
    
}
)
```
# Operador or ($or)

-Mostrar todos aquellos libros que cuesten mas de 25 o cuya cantidad sea inferiror a 15

```json
db.libros.find
({
$or: [
        {
            precio:{$gt:25}
        },
        {
            cantidad:{$lt:15}
        }
]
}
)

```
# Ejemplo con and y or combinados

-Mostrar los libros de la editorial Biblia, con precio mayor a 40 o libros con la editorial Planeta con precio mayor a 30.

```json
db.libros.find(
{$and:[
    {precio:$gt:40},
    
    {
    editorial: 
    {$in: ['Biblia', 'Planeta' ]}
    },

{$or:[
    {precio:$gt:30}
]
]
})


db.libros.find( 
{
    $and: [
        { $or: [ { editorial:'Biblio'}, {precio:{$gt:30}}]},
        { $or: [ { editorial:{$eq:'Planeta'}}, {precio:{$gt:20}}]}
    ]
} 
)
```

### Proyeccion (ver ciertas columnas)
***Sintaxis
```json
db.conexion.find(filtro, columnas)

1. Seleccionar todos los libros, solo mostrando el titulo.
1) db.libros.find({}, {titulo:1}) 
2) db.libros.find({titulo:1,_id:0})
```

### Operador Exist(0permite saber si un campo se encuentra o no en un documento)
```json
db.libros.find({editorial:{$exist:true}})

db.libros.find({editorial:{$exist:true}})
```
# Operador Type (permite solicitar a MongoDB si un campo corresponde a un tipo)

[Operador Type : https://www.mongodb.com/docs/manual/reference/operator/query/type/#mongodb-query-op.-type]
# Mostrar todos los dcumentos donde el precio sea de tipo double o entero o cualquier otro tipo de dato
```json
db.libros.find(
    {
        precio:{$type:16}
    }
)

db.libros.find(
    {
        precio:{$type:"int"}
    }   
)


db.libros.insertMany(
[
{
    _id:12,
    titulo:'IA',
    editorial:'Terra',
    precio:125,
    cantidad:20,
},
{
_id:13,
titulo:'Python para todos',
editorial: 2001,
precio: 200,
cantidad: 30
}
])
```
# Selccionar todo los docuementos de los libros donde los valores de la editorial sean string
```json
db.libros.find({editorial:{$type:2}})
db.libros.find({editorial:{$type:'string'}})
db.libros.find({editorial:{$type:16}})
db.libros.find({editorial:{$type:"int"}})
```


# Modificando Docuemntos
## Comandos importantes

1.Update->Modifica un solo documento
2.UpdateMany->Modificar multiples documentos
3.ReplaceOne->Sustituir el contenido completo de un documento

tiene el sigueinte formato
```json
db.collections.updateOne()
{filtro},
{operadores:}
)

**Operadores $set**

1. Mmodificar un documento
```json
db.libros.updateOne({titulo:'Python para todos'}, {$set:{titulo:'Java para todos'}})
``` 

```json
db.libros.insetOne(
    {
_id:10,
titulo: 'Mongo en Negocios Digitales',
editorial:'Terra',
precio:125
}
)
```

-- Modificar el documentos con id 10,estableciendo el precio en 100 y la cantidad en 50..
```json
db.libros.updateOne(
{
    _id:10
},

{
    $set:{precio: 100, cantidad:50}
})
```

--Utilizado el updateMany, modificar todos los libos donde el precios sea mayor a 100 cambiarlo por 150
```json
db.libros.updateMany(
    {

        precio:{$gt:100}
    },`
    {
       $set{precio:150}
    }
    )
    ```
   # Operadores $inc y $mul
   --   Incremetar todos los precios de los libros en 5
```json
db.libros.updateMany({},
{
$inc: {precio:5}
}
)
```
--multiplicar todos los libros donde la cantidad sea mayor a 20, multiplicar su cantidad por 2($mul)
```json
db.libros.updateMany(
    {
     cantidad:{$gt:20}
},
{
    $mul:
    {
        cantidad:2
    }
}
    )
 ```
 --Actualizar todos los libros multiplicando por 2 la cantidad y el precio de todos aquellos libros donde el precio sea mayor a 20
```json
 db.libros.updateMany
(
    {
        precio:{$gt:20}
    },
    {
    $mul:{cantidad:2, precio:2}
    }
)
```
# Remplazar docuemntos(repalceOne)
--Actualizar Todod el docuemnto del id 2 por el titulo 'De la tierra a la Luna',
editorial Terra, precio 100.
```json
db.libros.replaceOne(
    {_id:2},
    {
titulo:'De la Tierra a la Luna',
autor:'Julio Verne',
editorial:'Terra',
precio:100   
    })
```
### Reemplazar doumentos (replaceOne)
```json
1. Actualizar todo el documento del id 2 por el titulo: De la Tierra a la Luna, autor: Julio Verne, editorial: Terra, precio: 100
json
db.libros.replaceOne({_id:2}, 
{
    titulo: 'De la Tierra a la Luna',
    autor: 'Julio Verne',
    editorial: 'Terra',
    precio: 100
})

### Borrar Documentos
- Elimina un solo documento deleteOne
- Elimina multiples documentos deleteMany

1. Eliminar el documento con el id 2
json
db.libros.deleteOne({_id:2})


2. Eliminar todos los libros donde la cantidad es mayor a 150 
json
db.libros.deleteMany({cantidad: {$gt:150}})


### Expresiones Regulares

1. Seleccionar todos los libros que contengan una (t)
json
db.libros.find({titulo:/t/})


2. Seleccionar todos los libros que en el titulo contenga la palabra (json)
json
db.libros.find({titulo:/json/})


3. Seleccionar todos los libros que en el titulo terminen con (tos)
json
db.libros.find({titulo:/tos$/})


4. Seleccionar todos los titulos que comiences con (j)
json
db.libros.find({titulo:/^J/})
```

## Operador $regex
[Operadores Regex](https://www.mongodb.com/docs/manual/reference/operator/query/regex/)


--Seleccioanr los libros que contengan la palabra "para" en el tiitulo.
```json
db.libros.find({
    titulo:{
        $regex:'para'
    }
})

db.libros.find({
    titulo:{
        $regex:/para/
    }
})

--libros con json

db.libros.find({
    titulo:{
        $regex:/json/
    }
})

--Distiingur entre mayusculas y minusculas.

db.libros.find({
    titulo:{
        $regex:/json/i
    }
})

db.libros.find({
    titulo:{
        $regex:/json/, $options:'i'
    }
})


--Selccionar todos los docuementos de libros donde el titulo termine "es", no distinga entre mayusculas y minusculas.

db.libros.find({
    titulo:{
        $regex:/es$/, $options:'i'
    }
}
)

--ordenar los libros de anera acendente por el precio.

db.libros.find({},
{
    _id:0,
    titulo:1,
    precio:1
})sort({precio:1})
--ordenar los libros de anera acendente por el precio.

db.libros.find({},
{
    _id:0,
    titulo:1,
    precio:1
}).sort({precio:1})

--ordenar los libros de maner acendente porn la editorial y de manera acendente por el precio, mostrando, el titulo, el precio y la editorial.
db.libros.find(
{},
{
    _id:0,
    precio:1,
   editorial:1
})
.sort(
{
    editorial:1,
    precio:-1
    })

##ver libros
db.libros.find({}).size()

--que comiencen con j

db.libros.find({
    titulo:{
        $regex:/^j/, $options:'i'
    }
})

db.libros.find({
    titulo:{
        $regex:/^j/, $options:'i'
    }
}).size()

--buscar totos los libros pero mostrando los primeros
db.libros.find({}).limit(2)

--cambiar ele lugar de los libros
db.libros.find({}).skip(2)



```
### Método sort (Ordenar Documentos)

### Otros métodos (skip, limit, size)

### Borrar colecciones y base de datos



```json

```