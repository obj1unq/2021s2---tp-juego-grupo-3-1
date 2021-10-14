import wollok.game.*
import personaje.*
import direcciones.*

object rama{
	var property position = game.at(5,4)
	
	method sufijo() {
		
		return "rama"
	}
	
	method image(){
		return "rama.png"
	} 
	method fuerza() {
		return 1
	}
	
	method atacar(enemigo) {
		enemigo.recibirAtaque(self.fuerza())
	}	
}

object espada {
	
	var property position = game.center()
	
	method sufijo() {
		return "espada"
	}
	
	method image(){
		return "rama.png"
	}
	
	method fuerza() {
		return 3
	}
	
	method atacar(enemigo) {
		enemigo.recibirAtaque(self.fuerza())
	}	
}
