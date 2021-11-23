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
	
<<<<<<< HEAD
	method activarAtaque() {
		ataqueCercano.atacar()		
	}
=======
>>>>>>> branch 'master' of git@github.com:obj1unq/2021s2---tp-juego-grupo-3-1.git
	
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
<<<<<<< HEAD
	method serAgarrado() {}	
=======
	
	//polimorfismo
	method arrojarse() {}
>>>>>>> branch 'master' of git@github.com:obj1unq/2021s2---tp-juego-grupo-3-1.git
}

const manos = new Manos()

object rama{
	var property position = randomizer.emptyPosition()
	
	method image() = "rama.png"
	
<<<<<<< HEAD
	method atacar() {
		game.addVisualIn(self, personaje.posicionEnfrente())
		game.onCollideDo(self, {enemigo => enemigo.recibirDanio(self.danio())})
		game.schedule(50, {=> game.removeVisual(self)})
=======
	method sufijo() {
		return "-rama"
>>>>>>> branch 'master' of git@github.com:obj1unq/2021s2---tp-juego-grupo-3-1.git
	}
	
	method danio() {
		return 2
	}
	
<<<<<<< HEAD
	method serAgarrado(){}
}

class ArmaADistancia{
	const arma = arco
	var property position = game.at(1.randomUpTo(10), 1.randomUpTo(10))
		
	method image() = arma.toString() +".png"

	method sufijo() {
		return "-" + arma.toString()
	}

	method activarAtaque() {
			arma.activarAtaque()			
			
	}
		
	method serAgarrado() {
		personaje.equiparArma(self)
=======
	method activarAtaque() {
		ataqueCercano.atacar()
>>>>>>> branch 'master' of git@github.com:obj1unq/2021s2---tp-juego-grupo-3-1.git
	}
	
	method recibirDanio(danio){}
	
<<<<<<< HEAD

=======
	method serAgarrado() {
		personaje.equiparArma(self)
	}
	
	method arrojarse() {
		game.addVisualIn(self, direcciones.unaDireccionLibreDesde(personaje.position()).
							   siguiente(personaje.position())
		)
	}
>>>>>>> branch 'master' of git@github.com:obj1unq/2021s2---tp-juego-grupo-3-1.git
}


object arco{
<<<<<<< HEAD
	var property position = personaje.position()
=======
	var property position = randomizer.emptyPosition()
>>>>>>> branch 'master' of git@github.com:obj1unq/2021s2---tp-juego-grupo-3-1.git
	var property carga = 1

	method danio() {
		return 0
	}
	
	method activarAtaque() {
		if(carga > 0){
			carga -= 1
<<<<<<< HEAD
			new Municion(municion = new Flecha()).disparar()			
		}	
=======
			new Municion(nombre = "flecha").disparar()			
		}
		
>>>>>>> branch 'master' of git@github.com:obj1unq/2021s2---tp-juego-grupo-3-1.git
	}
	
	method recibirDanio(danio){}
	
	method recargar(){
		if(carga == 0) {carga += 1}
	}
	
	method arrojarse() {
		game.addVisualIn(self, direcciones.unaDireccionLibreDesde(personaje.position()).siguiente(personaje.position()))
	}
}

<<<<<<< HEAD
object baculo{
	var property position = personaje.position()
	var property carga = 1

	method danio() {
		return 0
	}
	
	method activarAtaque() {
		if(carga > 0){
			carga -= 1
			new Municion(municion = new BolaDeFuego()).disparar()			
		}	
	}
	
	method recibirDanio(danio){}
	
	method recargar(){
		if(carga == 0) {carga += 1}
	}
}

class Municion{
	var property position = personaje.position()
	var property orientacion = personaje.orientacion()
	var distancia = 4
	const property municion = new Flecha()

	method image() = municion.image()	
	
	method danio() = municion.danio()
		
=======
class Municion{
	
	var property position = personaje.position()
	const orientacion = personaje.orientacion()
	var distanciaPorRecorrer = 6
	const nombre
	
	method image() = nombre + orientacion.sufijo() +".png"
	
	method danio(){
		return 1
	}
	
>>>>>>> branch 'master' of git@github.com:obj1unq/2021s2---tp-juego-grupo-3-1.git
	method disparar(){
		game.addVisual(self)
<<<<<<< HEAD
		game.onTick(100, municion.toString(), {
			game.onCollideDo(self, {enemigo => enemigo.recibirDanio(self.danio()) self.borrar()})
=======
		game.onTick(70, "Movimiento de " + self.identity(), {
			game.onCollideDo(self, {enemigo => ataqueLejano.atacar(enemigo, self) self.borrar()})
>>>>>>> branch 'master' of git@github.com:obj1unq/2021s2---tp-juego-grupo-3-1.git
			self.mover(orientacion)
			distanciaPorRecorrer -= 1
			if(distanciaPorRecorrer == 0){
				self.borrar()
			}
		})
	}
	
	method borrar(){
		game.removeVisual(self)
<<<<<<< HEAD
		game.removeTickEvent(municion.toString())
=======
		game.removeTickEvent("Movimiento de " + self.identity())
>>>>>>> branch 'master' of git@github.com:obj1unq/2021s2---tp-juego-grupo-3-1.git
		arco.recargar()
		baculo.recargar()
	}
	
	method mover(direccion){
			position = direccion.siguiente(position)
	}
	
	//polimorfismo
	method recibirDanio(danio){}
	
}
<<<<<<< HEAD
class Flecha {
	var property orientacion = personaje.orientacion()
	method image() = "flecha"+ orientacion.sufijo() +".png"
	
	method danio(){
		return 1
	}

}

class BolaDeFuego inherits Flecha{

	override method image() = "bolaDeFuego"+ orientacion.sufijo() +".png"
	
	override method danio(){
		return 2
	}

}
=======



 
>>>>>>> branch 'master' of git@github.com:obj1unq/2021s2---tp-juego-grupo-3-1.git
