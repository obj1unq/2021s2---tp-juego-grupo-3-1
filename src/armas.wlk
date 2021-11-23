import wollok.game.*
import personaje.*
import geografia.*
import misc.*
import randomizer.*

object ataqueEnemigo {
	method image() = "ataqueEnemigo.png"
	
	method atacarPersonaje(_danio, direccion) {
		game.addVisualIn(self, personaje.position())
		game.schedule(150, {=> game.removeVisual(self)})
		personaje.recibirDanio(_danio, direccion)
	}
	
	//polimorfismo
	method serAgarrado() {}
	method recibirDanio(danio, direccion) {}
}

object ataqueLejano {
	
	method image() = "enemigoDaniado.png"
	
	method atacar(enemigo, municion, direccion) {
		game.addVisualIn(self, enemigo.position())
		enemigo.recibirDanio(municion.danio(), direccion)
		game.schedule(70, {=> game.removeVisual(self)})
	}
	
	//polimorfismo
	method serAgarrado() {}
	method recibirDanio(danio, direccion) {}
}

object ataqueCercano {
	
	method image() = "ataque" + personaje.arma().sufijo() + personaje.orientacion().sufijo() + ".png"
	
	
	method atacar(direccion) {
		if (!monitor.estaEnElJuego(self)) { //para controlar superposiciones de mensajes
			game.addVisualIn(self, personaje.posicionEnfrente())
			game.onCollideDo(self, {enemigo => enemigo.recibirDanio(self.danio(), direccion)})
			game.schedule(70, {=> game.removeVisual(self)})
		}
	}
	
	method danio() {
		return personaje.fuerzaDeAtaque()
	}
	
	
	//polimorfismo
	method serAgarrado() {}
	method recibirDanio(danio, direccion) {}
	
}

class Manos {
		
	method sufijo() {
		return ""
	}
	
	method danio() {
		return 1
	}
	
	method activarAtaque() {
		ataqueCercano.atacar(personaje.orientacion())
	}
	
	//polimorfismo
	method recibirDanio(_danio, direccion){}
	method arrojarse() {}
}

class ArmaCorta inherits Manos {
	const nombre
	const danio
	var property position = randomizer.emptyPosition()
	
	method image() = nombre + ".png"
	
	override method sufijo() {
		return "-" + nombre
	}
	
	override method danio() {
		return danio
	}
	
	override method arrojarse() {
		game.addVisualIn(self, direcciones.unaDireccionLibreDesde(personaje.position()).
							   siguiente(personaje.position())
		)
	}

	method serAgarrado() {
		personaje.equiparArma(self)
	}
}

class ArmaADistancia inherits ArmaCorta {
	var cargado = true
	const nombreMunicion

	override method activarAtaque() {
		if(cargado){
			cargado = false
			new Municion(nombre = nombreMunicion, armaAsociada = self).disparar()			
		}
	}
	
	
	method recargar(){
		cargado = true
	}
}

class Municion {
	
	var property position = personaje.position()
	const orientacion = personaje.orientacion()
	var distanciaPorRecorrer = 6
	const nombre
	const armaAsociada
	
	method image() = nombre + orientacion.sufijo() +".png"
	
	method danio(){
		return armaAsociada.danio()
	}
	
	method disparar(){
		game.addVisual(self)
		game.onTick(70, "Movimiento de " + self.identity(), {
			self.avanzar()
			self.verificarRecorrido()
		})
		game.schedule(75, {=> self.configurarColision()})
	}
	
	method configurarColision() {
		game.onCollideDo(self, {enemigo => 
			ataqueLejano.atacar(enemigo, self, orientacion) self.borrar()
		})
	}
	
	method borrar(){
		game.removeVisual(self)
		game.removeTickEvent("Movimiento de " + self.identity())
		armaAsociada.recargar()
	}
	
	method avanzar(){
		position = orientacion.siguiente(position)
		distanciaPorRecorrer -= 1
	}
	
	method verificarRecorrido() {
		if (distanciaPorRecorrer == 0) {
			self.borrar()
		}
	}
	
	//polimorfismo
	method serAgarrado() {}
	method recibirDanio(danio, direccion){}
	
}

const arco = new ArmaADistancia(nombre = "arco", danio = 1, nombreMunicion = "flecha")
const rama = new ArmaCorta(nombre = "rama", danio = 2)
const manos = new Manos()


 