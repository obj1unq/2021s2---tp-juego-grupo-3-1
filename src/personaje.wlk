import wollok.game.*
import direcciones.*
import armas.*

object personaje {
	
	var property position = game.at(3, 6)
	var orientacion = derecha
	var vida = 5
	var ropaje = "desnudo"
	var arma = espada
	const inventario = #{}
		
	method image() {
		return "pj-" + ropaje + arma.sufijo() + orientacion.sufijo() + ".png"
	}
		
	method mover(direccion) {
		if (!direccion.esElBorde(position)) {
			position = direccion.siguiente(position)
		}
		orientacion = direccion
	}
	
	method atacar(enemigo) {
		enemigo.recibirAtaque(arma.fuerza())
	}
	
	method agarrarItem() {
		arma = game.uniqueCollider(self)
		game.removeVisual(game.uniqueCollider(self))
	}
	
	method soltarArma() {
		game.addVisualIn(arma, position.up(1))
		arma = manos
	}
	
	method cambiarRopaje(objeto){
		ropaje = objeto.sufijo() 
	}
	
	method equiparYDesparecer(objeto){
		self.cambiarRopaje(objeto)
		game.removeVisual(objeto)
	}
}
