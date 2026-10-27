
object refugio {
    var property familias = []
    var property animales = []

// Recorro los animales del refugio (filter) -> para cada animal, compruebo si alguna familia puede adoptarlo (any) ->
// niego el resultado (not) para quedarme únicamente con los animales que ninguna familia puede adoptar

    method noPuedenSerAdoptados() {
        animales.filter( { unAnimal => not familias.any( { unaFamilia => unaFamilia.puedeAdoptarlo(unAnimal) })})
    }

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