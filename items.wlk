import wollok.game.*
import personaje.*
import enemigos.*

class Pocion inherits EnemigoMuerto {
	
	override method image() {
		return "pocion.png"
	}
	
	override method serAgarrado() {
		game.removeVisual(self)
		self.curarPersonaje()
	}
	
	method curarPersonaje(){
		personaje.recuperarVida(3)
	}
}
