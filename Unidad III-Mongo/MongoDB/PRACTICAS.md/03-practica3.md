# Practica 3. Updates y Deletes

1. Cambiar el salario del empleado Imogene Nolan. Se le asigna 8000.
```json
db.empleados.updateOne(
  { nombre: "Imogene", apellidos: "Nolan" },
  { $set: { salario: 8000 } }
)
![alt text](image-8.png)
```
2. Cambiar "Belgium" por "Bélgica" en los empleados (debe haber dos).
```json
db.empleados.updateMany(
  { pais: "Belgium" },
  { $set: { pais: "Bélgica" } }
)
![alt text](image-9.png)
```
4. Reemplazar el empleado Omar Gentry por el siguiente documento:

```json
{
"nombre": "Omar",
"apellidos": "Gentry",
"correo": "sin correo",
"direccion": "Sin calle",
"region": "Sin region",
"pais": "Sin pais",
"empresa": "Sin empresa",
"ventas": 0,
"salario": 0,
"departamentos": "Este empleado ha sido anulado"
}

--Cambio
db.empleados.updateOne(
  { nombre: "Omar", apellidos: "Gentry" },
  {
    $set: {
      correo: "sin correo",
      direccion: "Sin calle",
      region: "Sin region",
      pais: "Sin pais",
      empresa: "Sin empresa",
      ventas: 0,
      salario: 0,
      departamentos: "Este empleado ha sido anulado"
    }
  }
)
![alt text](image-10.png)
```

5. Con un find comprobar que el empleado ha sido modificado
```json
db.empleados.find({nombre:{$in:['Omar']}})
![alt text](image-11.png)
```

6. Borrar todos los empleados que ganen mas de 8500. Nota: deben ser borrados 3 documentos
```json
db.empleados.find({salario: {$lt:8500})

db.empleados.deleteMany({salario: {$lt:8500}})

```
7. Visualizar con una expresión regular todos los empleados con apellidos que comiencen con "R"
```json

db.empleados.find(
  { apellidos: { $regex: /^R/ } }
).pretty()
![alt text](image-12.png)
```
8. Buscar todas las regiones que contenga un "V". Hacerlo con el operador $regex y que no distinga mayúsculas y minúsculas. Deben salir 2.
```json
db.empleados.find(
  { region: { $regex: /v/i } },
  { region: 1, _id: 0 }
).pretty()

![alt text](image-13.png)

```
9. Visualizar los apellidos de los empleados ordenados por el propio apellido.
```json
db.empleados.find(
  {},
  { apellidos: 1, _id: 0 }
).sort({ apellidos: 1 })

![alt text](image-14.png)

```
10. Indicar el número de empleados que trabajan en Google.
```json
db.empleados.countDocuments(
  { empresa: "Google" }
)

![alt text](image-15.png)

```
11. Borrar la colección empleados y la base de datos
```json
db.empleados.drop()
__________
use empleados
db.dropDatabase('empleado')

```