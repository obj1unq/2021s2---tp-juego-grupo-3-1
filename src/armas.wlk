import wollok.game.*
import personaje.*
import direcciones.*
import misc.*
import randomizer.*

object ataqueEnemigo {
	method image() = "ataqueEnemigo.png"
	
	method atacarPersonaje(_danio) {
		game.addVisualIn(self, personaje.position())
		game.schedule(150, {=> game.removeVisual(self)})
		personaje.recibirDanio(_danio)
	}
	
	//polimorfismo
	method serAgarrado() {}
	method recibirDanio(danio) {}
}

object ataqueLejano {
	
	method image() = "enemigoDaniado.png"
	
	method atacar(enemigo, municion) {
		game.addVisualIn(self, enemigo.position())
		enemigo.recibirDanio(municion.danio())
		game.schedule(70, {=> game.removeVisual(self)})
	}
	
	//polimorfismo
	method serAgarrado() {}
	method recibirDanio(danio) {}
}

object ataqueCercano {
	
	method image() = "ataque" + personaje.arma().sufijo() + personaje.orientacion().sufijo() + ".png"
	
	
	method atacar() {
		if (!monitor.estaEnElJuego(self)) { //para controlar superposiciones de mensajes
			game.addVisualIn(self, personaje.posicionEnfrente())
			game.onCollideDo(self, {enemigo => enemigo.recibirDanio(self.danio())})
			game.schedule(70, {=> game.removeVisual(self)})
		}
	}
	
	method danio() {
		return personaje.fuerzaDeAtaque()
	}
	
	
	//polimorfismo
	method serAgarrado() {}
	method recibirDanio(danio) {}
	
}

class Manos {
	const property ataque = ataqueCercano
	
	method sufijo() {
		return ""
	}
	
	method danio() {
		return 1
	}
	
	method activarAtaque() {
		ataqueCercano.atacar()
	}
	
	//polimorfismo
	method arrojarse() {}
}

const manos = new Manos()

object rama{
	var property position = randomizer.emptyPosition()
	
	method image() = "rama.png"
	
	method sufijo() {
		return "-rama"
	}
	
	method danio() {
		return 2
	}
	
	method activarAtaque() {
		ataqueCercano.atacar()
	}
	
	method recibirDanio(danio){}
	
	method serAgarrado() {
		personaje.equiparArma(self)
	}
	
	method arrojarse() {
		game.addVisualIn(self, direcciones.unaDireccionLibreDesde(personaje.position()).
							   siguiente(personaje.position())
		)
	}
}


object arco{
	var property position = randomizer.emptyPosition()
	var property carga = 1

	method image() = "arco.png"
	
	method sufijo() {
		return "-arco"
	}
	
	method danio() {
		return 0
	}
	
	method activarAtaque() {
		if(carga > 0){
			carga -= 1
			new Municion(nombre = "flecha").disparar()			
		}
		
	}
	
	method recibirDanio(danio){}
	
	method serAgarrado() {
		personaje.equiparArma(self)
	}
	
	method recargar(){
		carga += 1
	}
	
	method arrojarse() {
		game.addVisualIn(self, direcciones.unaDireccionLibreDesde(personaje.position()).siguiente(personaje.position()))
	}
}

class Municion{
	
	var property position = personaje.position()
	const orientacion = personaje.orientacion()
	var distanciaPorRecorrer = 6
	const nombre
	
	method image() = nombre + orientacion.sufijo() +".png"
	
	method danio(){
		return 1
	}
	
	method disparar(){
		game.addVisual(self)
		game.onTick(70, "Movimiento de " + self.identity(), {
			game.onCollideDo(self, {enemigo => ataqueLejano.atacar(enemigo, self) self.borrar()})
			self.mover(orientacion)
			distanciaPorRecorrer -= 1
			if(distanciaPorRecorrer == 0){
				self.borrar()
			}
		})
	}
	
	method borrar(){
		game.removeVisual(self)
		game.removeTickEvent("Movimiento de " + self.identity())
		arco.recargar()
	}
	
	method mover(direccion){
			position = direccion.siguiente(position)
	}
	
	//polimorfismo
	method recibirDanio(danio){}
	
}



 