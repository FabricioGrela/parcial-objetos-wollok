/*

De cada familia conocemos las personas que la componen, las mascotas que tienen y el 
tamaño (en unidades de espacio) de la casa en donde viven. De cada persona sabemos, 
edad y si es alérgica. También sabemos la lista de animales que no les caen bien. 
De momento contamos con tres tipos diferentes de animales: Perros, gatos y peces 
dorados. Todos los animales tienen un nombre asignado. 
Resolver los siguientes requerimientos aplicando los conceptos del paradigma orientado a 
objetos. Anexar a la solución un diagrama estático para comunicar el diseño de la solución. 
1.  Necesitamos saber si una familia tiene lugar para un animal. Esto ocurre cuando la 
casa familiar tiene disponible el lugar que el animal ocupa. 
a.  Cada persona de la familia utiliza 1 unidad de espacio de la casa si son 
mayores de 13 años y 0.75 si no lo son. 
b.  En cuanto a los animales, los gatos ocupan 0.5 unidades. 
c.  Los peces dorados no ocupan espacio significativo. 
d.  En el caso de los perros dependerá mayormente de su raza (hay razas 
chicas como los chihuahuas y grandes como los rottweilers). Los perros de 
raza chica utilizan 0.5 unidades, mientras que para los de razas grandes se 
indicará para cada raza cuánto ocupan.

*/

class Familia {
    var property personas = []
    var property mascotas = []
    var property tamanio

    // consigo todo el espacio de la familia (espacioOcupado) -> obtengo el espacio disponible (espacioLibre) -> lo comparo con el espacio que ocupa la mascota (tieneLugar)

    method espacioLibre() = tamanio - self.espacioOcupado()

    method espacioOcupado() {
      return personas.map( { unaPersona => unaPersona.espacioQueOcupa() } ).sum() + mascotas.map( { unaMascota => unaMascota.espacioQueOcupa() } ).sum()
    }

    method tieneLugar(unAnimal) = unAnimal.espacioQueOcupa() <= self.espacioLibre()
}

class Persona {
    var property edad
    const property esAlergica
    const property animalesQueNoLeCaenBien = []
    method espacioQueOcupa(){
        if (edad <= 13) {
            return 0.75
        } else return 1
    }
}

class Animal {
    const property nombre
    method espacioQueOcupa()
}

class Gato inherits Animal {
    override method espacioQueOcupa() = 0.5
}

class Pez inherits Animal {
    override method espacioQueOcupa() = 0
}

class Perro inherits Animal {
    const property raza
    override method espacioQueOcupa() = raza.espacioQueOcupa()
}

class Raza {
    method espacioQueOcupa()
}

class RazaChica inherits Raza {
    override method espacioQueOcupa() = 0.5
}

class RazaGrande inherits Raza {
    const espacio
    override method espacioQueOcupa() = espacio
}