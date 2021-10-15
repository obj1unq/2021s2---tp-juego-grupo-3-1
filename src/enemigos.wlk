import wollok.game.*
import personaje.*
import armas.*
import direcciones.*

object bichoAzul {
	var property position = game.at(5, 7)
 	var vida = 6
 	var orientacion = derecha

	method image() = "bichoAzul" + orientacion.sufijo() + ".png"
	
	method recibirAtaque(fuerza) {
		vida = 0.max(vida - fuerza)
	}
	
	method murio() {
		return vida == 0
	}
	
	method desaparecer() {
		game.removeVisual(self)
	}
	
	method mover(direccion) {
		if (!direccion.esElBorde(position)) {
			position = direccion.siguiente(position)
			orientacion = direccion
		} else {
			position = direccion.opuesto().siguiente(position)
			orientacion = direccion.opuesto()
		}
	}
	
	
	
}
