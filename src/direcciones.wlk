import wollok.game.*

object izquierda {
	
	method siguiente(posicion) {
		return posicion.left(1)	
	}
	
	method sufijo() {
		return "izquierda"
	}
	
	method esElBorde(posicion) {
		return posicion.x() == 0
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
		return "derecha"
	}
	
	method esElBorde(posicion) {
		return posicion.x() == 14
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
		return "arriba"
	}
	
	method esElBorde(posicion) {
		return posicion.y() == 11
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
		return "abajo"
	}

	method esElBorde(posicion) {
		return posicion.y() == 0
	}
	
	method opuesto() {
		return arriba
	}	

}

object direccionAleatoria {
	
	method generar() {
		var num = 0.randomUpTo(4).roundUp()
		const direcciones = ["relleno", arriba, izquierda, abajo, derecha]
		return direcciones.get(num)
	}
}		

	
	
	