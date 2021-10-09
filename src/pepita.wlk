import wollok.game.*

object nave {

	var property position = game.origin()
	
	method position() = game.center()

	method image() = "nave.png"
	
	method subir() {
    position = position.up(1) 
  }
	method bajar() {
    position = position.down(1) 
  }
}

// direcciones

object izquierda {
	method siguiente(posicion) {
		return posicion.left(1)
	}
	
	method sufijo() {
		return "der"
	}
		
}
object derecha {
	method siguiente(posicion) {
		return posicion.right(1)
	}
	
	method sufijo() {
		return "der"
	}
		
}

object arriba {
	method siguiente(posicion) {
		return posicion.up(1)
	}
	
	method sufijo() {
		return "izq" //todo pensar mejor que devolver
	}		
}

object abajo {
	method siguiente(posicion) {
		return posicion.down(1)
	}
	method sufijo() {
		return "izq" //todo pensar mejor que devolver
	}		
		
}