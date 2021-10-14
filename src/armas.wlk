import wollok.game.*
import personaje.*
import direcciones.*


object espada {
	
	method fuerza() {
		return 1
	}
	
	method atacar(enemigo) {
		enemigo.recibirAtaque(self.fuerza())
	}	
}
