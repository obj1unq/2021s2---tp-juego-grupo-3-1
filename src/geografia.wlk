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
	
	method opuesto() {
		return derecha
	}
	
	method avanzarUno(posicion) {
		posicion.x(posicion.x()-1)
	}
}

object derecha {

	method siguiente(posicion) {
		return posicion.right(1)	
	}
	
	method sufijo() {
		return "-derecha"
	}
	

	method opuesto() {
		return izquierda
	}
	
	method avanzarUno(posicion) {
		posicion.x(posicion.x()+1)
	}
	
}

object arriba {

	method siguiente(posicion) {
		return posicion.up(1)	
	}
	
	method sufijo() {
		return "-arriba"
	}
	
	method opuesto() {
		return abajo
	}
	
	method avanzarUno(posicion) {
		posicion.y(posicion.y()+1)
	}
	
}

object abajo {

	method siguiente(posicion) {
		return posicion.down(1)	
	}
	
	method sufijo() {
		return "-abajo"
	}

	method opuesto() {
		return arriba
	}
	
	method avanzarUno(posicion) {
		posicion.y(posicion.y()-1)
	}
}

object direcciones {
	method lista() {
		return [abajo, izquierda, arriba, derecha]
	}
	
	method aleatoria() {
		return self.lista().anyOne()
	}

	method esUnBorde(posicion) {
		return posicion.y() == 0 || posicion.y() == 11 || posicion.x() == 0 || posicion.x() == 14
	}
	
	method estaVacio(posicion) {
		return game.getObjectsIn(posicion).isEmpty()
	}
	
	method estaLibre(posicion) {
		return self.estaVacio(posicion) && !self.esUnBorde(posicion)
	}
	
	method unaDireccionLibreDesde(posicion) {
		const dirAl = self.aleatoria()
		return if (self.estaLibre(dirAl.siguiente(posicion)) &&
				!self.frenteALaPuerta(dirAl.siguiente(posicion))
		) {dirAl} 
				else {self.unaDireccionLibreDesde(posicion)}
	}
	
	method estaElPersonajeHacia(posicion) {
		return game.getObjectsIn(posicion).contains(personaje)
	}
	
	method frenteALaPuerta(posicion) {
		return posicion.x() == 12 && posicion.y() == 10
	}
	 
}

class MiPosicion {
	var property x = 0
	var property y = 0
	
	method right(n) = new MiPosicion(x = x+n, y = y)
	method left(n) = new MiPosicion(x = x-n, y = y)
	method up(n) = new MiPosicion(x = x, y = y+n)
	method down(n) = new MiPosicion(x = x, y = y-n)
	
	method clone() {
		return new MiPosicion(x = x, y = y)
	}
}
	
	
	