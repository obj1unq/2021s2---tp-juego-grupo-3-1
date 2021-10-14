import wollok.game.*
import direcciones.*

object personaje {
	
	var property position = game.at(3, 6)
	var orientacion = "derecha"
	var vida = 5
	var ropaje = "desnudo"
	
	method image() {
		return "pj-" + ropaje + "-" + orientacion + ".png"
	}
		
	method mover(direccion) {
		if (!direccion.esElBorde(position)) {
			position = direccion.siguiente(position)
		}
		orientacion = direccion.sufijo()
	}
	

	
}
