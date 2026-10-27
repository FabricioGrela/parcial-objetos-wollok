object refugio {
    var property familias = []
    var property animales = []

    // 3.
    // Recorro los animales del refugio (filter) -> para cada animal, compruebo si alguna familia puede adoptarlo (any) ->
    // niego el resultado (not) para quedarme únicamente con los animales que ninguna familia puede adoptar

    method noPuedenSerAdoptados() {
        animales.filter( { unAnimal => not familias.any( { unaFamilia => unaFamilia.puedeAdoptarlo(unAnimal) })})
    }

    // 4.
    // quizás el self.animales().contain(unAnimal) es demasiado? preguntar en clase
    method adoptarUnAnimal(unaFamilia, unAnimal){
        if(self.animales().contains(unAnimal) and unaFamilia.puedeAdoptarlo(unAnimal)){
            unaFamilia.mascotas().add(unAnimal)
            self.animales().remove(unAnimal)
        }
    }
}

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

    method puedeAdoptarlo(unAnimal) = self.tieneLugar(unAnimal) and not personas.any( {unaPersona => unaPersona.animalesQueNoLeCaenBien().contains(unAnimal) } )

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

// 5.a
class PerroSalvaje inherits Perro {
    override method esPeludo() = true
    override method espacioQueOcupa() = raza.espacioQueOcupa() * 2
    override method tieneProblemasCon(unAnimal) = unAnimal.espacioQueOcupa() == 0.5
}

class Raza {

    method espacioQueOcupa()
    method esPeludo()
    method tieneProblemasCon(unAnimal)

}

class RazaChica inherits Raza {

    const property esPeludo

    override method espacioQueOcupa() = 0.5
    override method tieneProblemasCon(unAnimal) = self.espacioQueOcupa() < unAnimal.espacioQueOcupa()

}

class RazaGrande inherits Raza {

    const espacio
    const property esPeludo

    override method espacioQueOcupa() = espacio
    override method tieneProblemasCon(unAnimal) = false
}

// 5.b
class RazaCruza inherits Raza {

    // En orden -> la primera es la más importante
    const property razas = []

    method cantidadDeRazas() = razas.size()

    override method espacioQueOcupa() = razas.sum({ unaRaza => unaRaza.espacioQueOcupa() }) / self.cantidadDeRazas()
    override method esPeludo() = razas.first().esPeludo()
    override method tieneProblemasCon(unAnimal) = razas.all({ unaRaza => unaRaza.tieneProblemasCon(unAnimal) })

}

// 5.c
// Razas simples
const rottweiler = new RazaGrande(espacio = 0.8, esPeludo = false)
const chihuahua  = new RazaChica(esPeludo = false)
const siberiano  = new RazaGrande(espacio = 0.7, esPeludo = true)

// Cruza: el orden importa (de mas a menos predominante)
const cruza = new RazaCruza(razas = [rottweiler, chihuahua, siberiano])

// Perro salvaje cuya raza es la cruza
const perroSalvaje = new PerroSalvaje(nombre = "akamaru", raza = cruza)