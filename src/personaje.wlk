import wollok.game.*
import direcciones.*
import armas.*

object personaje {
	
	var property position = game.at(3, 6)
	var orientacion = derecha
	var vida = 5
	var ropa = "desnudo"
	var arma = manos
	var escudo
		
	method image() {
		return "pj-" + ropa + arma.sufijo() + orientacion.sufijo() + ".png"
	}
		
	method mover(direccion) {
		if (!direccion.esElBorde(position) && direccion.estaVacio(direccion.siguiente(position))) {
			position = direccion.siguiente(position)
		}
		orientacion = direccion
	}
	
	method posicionEnfrente() {
		return orientacion.siguiente(position)
	}
	
	
	
	method fuerzaDeAtaque() {
		return arma.danio()
	}
	
	method atacar() {
		arma.activarAtaque()
	}
	
	method agarrarItem() {
		game.getObjectsIn(self.posicionEnfrente()).forEach({item => item.serAgarrado()})
	}
	
	method equiparArma(_arma) {
		arma = _arma
		game.removeVisual(_arma)
	}
	
	method equiparEscudo(_escudo) {
		escudo = _escudo
		game.removeVisual(_escudo)
	}
	
	method cambiarRopa(_ropa) {
		ropa = _ropa
		game.removeVisual(_ropa)
	}
	
	method soltarArma() {
		game.addVisualIn(arma, orientacion.siguiente(position))
		arma = manos
	}
	
}
