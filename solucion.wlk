/*

2. Queremos saber si una persona o mascota tiene problemas con un animal, para
determinar si querrían adoptarlo.
Los humanos tienen problemas con los animales que no les caen bien y, en caso de
ser alérgicos, con los animales peludos (o sea, los gatos, y los perros de razas
peludas).
Por otro lado, para los perros de razas chicas, suelen tener problemas con animales
que ocupan más espacio que ellos.
Finalmente hay gatos mala onda que tienen problemas con cualquier animal (se
indicará para cada caso si tienen esta particularidad), y los peces dorados no tienen
problemas con nadie.

-> peludo, metodo esPeludo?
-> razaChica, metodo tieneProblemas?
-> gatos, metodo malaOnda? atributo?
-> metodo tieneProblemas en general y que reciba otraMascota?

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

    method tieneProblemasCon(unAnimal) = animalesQueNoLeCaenBien.contains(unAnimal) or ( self.esAlergica() and unAnimal.esPeludo() )

}

class Animal {
    const property nombre
    method espacioQueOcupa()
    method esPeludo()
    method tieneProblemasCon(unAnimal) = false // preguntar al profe
}

class Gato inherits Animal {
    const property esMalaOnda
    override method espacioQueOcupa() = 0.5
    override method esPeludo() = true
    override method tieneProblemasCon(unAnimal) = esMalaOnda
}

class Pez inherits Animal {
    override method espacioQueOcupa() = 0
    override method esPeludo() = false
    override method tieneProblemasCon(unAnimal) = false
}

class Perro inherits Animal {
    const property raza
    override method espacioQueOcupa() = raza.espacioQueOcupa()
}

class Raza {
    method espacioQueOcupa()
    method esPeludo()
}

class RazaChica inherits Raza {
    override method espacioQueOcupa() = 0.5

    method tieneProblemasCon(unAnimal) = self.espacioQueOcupa() < unAnimal.espacioQueOcupa()

}

class RazaGrande inherits Raza {
    const espacio
    override method espacioQueOcupa() = espacio
}