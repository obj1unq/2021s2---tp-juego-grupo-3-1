import wollok.game.*

object izquierda {
	method siguiente(posicion) {
		if(self.puedeMover(posicion)){
			return posicion.left(1)	
		} else {
			return posicion
		}
	}
	
	method sufijo() {
		return "izq"
	}
	
	method puedeMover(position){ 
		return !(position.x() == 0)
	}
}

object derecha {
	method siguiente(posicion) {
		if(self.puedeMover(posicion)){
			return posicion.right(1)	
		} else {
			return posicion
		}
	}
	
	method sufijo() {
		return "der"
	}
	
	method puedeMover(position){ 
		return !(position.x() == 19)
	}
}

object arriba {
	method siguiente(posicion) {
		if(self.puedeMover(posicion)){
			return posicion.up(1)	
		} else {
			return posicion
		}
	}
	
	method sufijo() {
		return "arriba"
	}		
	
	method puedeMover(position){ 
		return !(position.y() == 9)
	}
}

object abajo {
	method siguiente(posicion) {
		if(self.puedeMover(posicion)){
			return posicion.down(1)	
		} else {
			return posicion
		}
	}
	
	method sufijo() {
		return "abajo"
	}	
	
	method puedeMover(posicion){ 
		return !(posicion.y() == 0)
	}	
}