import wollok.game.*

object arriba {
	
	method siguienteDesde(direccion) {
		return direccion.up(1)
	}
	
	method sufijo() {
		return ""
	}
	
	method opuesto() {
		return abajo
	}
}

object abajo {
	
	method siguienteDesde(direccion) {
		return direccion.down(1)
	}
	
	method sufijo() {
		return ""
	}
	
	method opuesto() {
		return arriba
	}
}

object izquierda {
	
	method siguienteDesde(direccion) {
		return direccion.left(1)
	}
	
	method sufijo() {
		return "-izquierda"
	}
	
	method opuesto() {
		return derecha
	}
}

object derecha {
	
	method siguienteDesde(direccion) {
		return direccion.right(1)
	}
	
	method sufijo() {
		return "-derecha"
	}
	
	method opuesto() {
		return izquierda
	}
}