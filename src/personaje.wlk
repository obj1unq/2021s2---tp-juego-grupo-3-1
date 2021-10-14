import wollok.game.*
import direcciones.*
import armas.*

object personaje {
	
	var property position = game.at(3, 6)
	var orientacion = "derecha"
	var vida = 5
	var ropaje = "desnudo"
	var equipamiento = #{}
		
	method image() {
		return "pj-" + ropaje + "-" + orientacion + ".png"
	}
		
	method mover(direccion) {
		if (!direccion.esElBorde(position)) {
			position = direccion.siguiente(position)
		}
		orientacion = direccion.sufijo()
	}
	
	method cambiarRopaje(objeto){
		ropaje = objeto.sufijo() 
	}
	method equiparYDesparecer(objeto){
	
		self.cambiarRopaje(objeto)
		game.removeVisual(objeto)
	}
	
	method agarrarArmamento(){
		const armamento = game.colliders(self)
		armamento.forEach({arma => self.equiparYDesparecer(arma)})
		
	}
	

	
}
