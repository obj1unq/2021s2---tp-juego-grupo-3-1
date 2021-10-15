import wollok.game.*
import personaje.*
import direcciones.*

object rama{
	var property position = game.at(5,4)
	method image() = "rama.png"	
	
	method sufijo() {
		return "-rama"
	}
	
	method fuerza() {
		return 1
	}
	
}

object espada {
	var property position
	method image() = ""
	
	method sufijo() {
		return ""
	}
}

object manos {
	
	method sufijo() {
		return ""
	}
}
