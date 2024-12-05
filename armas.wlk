import wollok.game.*
import personaje.*
import geografia.*
import misc.*
import randomizer.*
import enemigos.*

object ataqueEnemigo inherits Polimorfi {
	
	method position() {
		return personaje.position()
	}
	
	method image() = "ataqueEnemigo.png"
	
	method atacarPersonaje(_danio, direccion) {
		if (!monitor.estaEnElJuego(self)){
			game.addVisual(self)
			game.schedule(150, {=> game.removeVisual(self)})
		}
		personaje.recibirDanio(_danio, direccion)
	}
}

object ataqueLejano inherits Polimorfi {
	
	method image() = "enemigoDaniado.png"
	
	method atacar(enemigo, municion, direccion) {
		game.addVisualIn(self, enemigo.position())
		enemigo.recibirDanio(municion.danio(), direccion)
		game.schedule(70, {=> game.removeVisual(self)})
	}
}

object ataqueCercano inherits Polimorfi {
	
	method image() = "ataque" + personaje.arma().sufijo() + personaje.orientacion().sufijo() + ".png"
	
	
	method atacar(direccion) {
		if (!monitor.estaEnElJuego(self)) {
			game.addVisualIn(self, personaje.posicionEnfrente())
			game.onCollideDo(self, {enemigo => enemigo.recibirDanio(self.danio(), direccion)})
			game.schedule(70, {=> game.removeVisual(self)})
		}
	}
	
	method danio() {
		return personaje.fuerzaDeAtaque()
	}
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
	method arrojarse() {}
	method recibirDanio(danio, direccion) {}
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
		const nuevaPosicion = direcciones.unaPosicionLibreDesde(personaje.position())
		position.x(nuevaPosicion.x())
		position.y(nuevaPosicion.y())
		game.addVisual(self)
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

class Municion inherits Polimorfi {
	
	var property position = personaje.position().clone()
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
		game.removeTickEvent("Movimiento de " + self.identity())
		game.removeVisual(self)
		armaAsociada.recargar()
	}
	
	method avanzar(){
		orientacion.avanzarUno(position)
		distanciaPorRecorrer -= 1
	}
	
	method verificarRecorrido() {
		if (distanciaPorRecorrer == 0) {
			self.borrar()
		}
	}	
}

class AtaqueBoss inherits Polimorfi {
	const property position = abajo.siguiente(boss.position())
	method image() = "ataqueBoss.png"
	
	method configurarColision() {
		game.onCollideDo(self, {personaje => 
			self.desaparecer()
			personaje.recibirDanio(2, abajo)
		})
	}
	
	method avanzar() {
		if (self.enJuego()) {
			abajo.avanzarUno(position)
		} else {self.desaparecer()}
	}
	
	method desaparecer() {
		game.removeTickEvent("Movimiento de " + self.identity())
		game.removeVisual(self)
	}
	
	method enJuego() {
		return position.x() > 0
	}
}

const arco = new ArmaADistancia(nombre = "arco", danio = 2, nombreMunicion = "flecha")
const rama = new ArmaCorta(nombre = "rama", danio = 2)
const manos = new Manos()
const baculo = new ArmaADistancia(nombre = "baculo", danio = 3, nombreMunicion = "bolaDeFuego")


 