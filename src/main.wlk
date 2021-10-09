import wollok.game.*
import posiciones.*

object main {
	
	var property position = game.origin()
	var direccion = izquierda

	method image() = "main.png"
	
	method mover(_direccion) {
		direccion = _direccion
		self.irA(_direccion.siguiente(self.position()))
	}

	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}

}