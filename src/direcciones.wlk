import wollok.game.*
import personaje.*
import enemigos.*

object izquierda {
	
	method siguiente(posicion) {
		return posicion.left(1)	
	}
	
	method sufijo() {
		return "-izquierda"
	}
	
	method esElBorde(posicion) {
		return posicion.x() == 1
	}
	
	method opuesto() {
		return derecha
	}
}

object derecha {

	method siguiente(posicion) {
		return posicion.right(1)	
	}
	
	method sufijo() {
		return "-derecha"
	}
	
	method esElBorde(posicion) {
		return posicion.x() == 13
	}

	method opuesto() {
		return izquierda
	}
	
}

object arriba {

	method siguiente(posicion) {
		return posicion.up(1)	
	}
	
	method sufijo() {
		return "-arriba"
	}
	
	method esElBorde(posicion) {
		return posicion.y() == 10
	}

	method opuesto() {
		return abajo
	}
	
}

object abajo {

	method siguiente(posicion) {
		return posicion.down(1)	
	}
	
	method sufijo() {
		return "-abajo"
	}

	method esElBorde(posicion) {
		return posicion.y() == 1
	}
	
	method opuesto() {
		return arriba
	}
}

object direcciones {
	method lista() {
		return [abajo, izquierda, arriba, derecha]
	}
	
	method aleatoria() {
		return self.lista().anyOne()
	}

	method estaVacio(posicion) {
		return game.getObjectsIn(posicion).isEmpty()
	}
	
	method unaDireccionLibreDesde(posicion) {
		const direccion = self.aleatoria()
		if (self.estaVacio(direccion.siguiente(posicion)) && !direccion.esElBorde(posicion)) {
			return direccion
		} else {return self.unaDireccionLibreDesde(posicion)}
	}
	
	method estaElPersonajeHacia(direccion, posicion) {
		return game.getObjectsIn(direccion.siguiente(posicion)).contains(personaje)
	}
	 
}

	
	
	