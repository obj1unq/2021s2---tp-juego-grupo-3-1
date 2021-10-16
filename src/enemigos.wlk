import wollok.game.*
import personaje.*
import armas.*
import direcciones.*

object bichoAzul {
	var property position = game.at(5, 7)
 	var vida = 6
 	var orientacion = derecha

	method image() = "bichoAzul" + orientacion.sufijo() + ".png"
	
	method recibirDanio(danio) {
		if (vida - danio <= 0) {
			self.desaparecer()
		} else {vida -= danio}
	}
	
	method desaparecer() {
		game.removeVisual(self)
	}
	
	method mover(direccion) {
		if (self.puedeMover(direccion)) {
			position = direccion.siguiente(position)
			orientacion = direccion
		} else if (self.puedeMover(direccion.opuesto())) {
			position = direccion.opuesto().siguiente(position)
			orientacion = direccion.opuesto()
		}
	}
	
	method puedeMover(direccion) {
		return !direccion.esElBorde(position) && direccion.estaVacio(direccion.siguiente(position))
	}
	
	
	
	//metodos de relleno para polimorfismo
	method serAgarrado(){}
	
	
	
}
