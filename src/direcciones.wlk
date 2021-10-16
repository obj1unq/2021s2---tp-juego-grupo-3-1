import wollok.game.*

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
	
	method estaVacio(posicion) {
		return game.getObjectsIn(posicion).isEmpty()
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
	
	method estaVacio(posicion) {
		return game.getObjectsIn(posicion).isEmpty()
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
	
	method estaVacio(posicion) {
		return game.getObjectsIn(posicion).isEmpty()
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

	method estaVacio(posicion) {
		return game.getObjectsIn(posicion).isEmpty()
	}
}

object direccionAleatoria {
	
	method generar() {
		var num = 0.randomUpTo(4).roundUp()
		const direcciones = ["relleno", arriba, izquierda, abajo, derecha]
		return direcciones.get(num)
	}
}		

	
	
	