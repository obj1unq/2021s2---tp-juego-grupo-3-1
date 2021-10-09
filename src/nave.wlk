import wollok.game.*


object nave{
	var property position =game.origin()
	var property cargador = [proyectil]
	var direccion
	method image(){
		return "nave1.png"
		
	}
	
//	method moverA(_direccion){
//
//		if(_direccion == "up"){
//			position = position.up(1)
//		}	if(_direccion == "down"){
//				position = position.down(1)
//			}if(_direccion == "left"){
//				position = position.left(1)
//			}if(_direccion == "right"){
//				position = position.right(1)
//			}
//		}
	
	method mover(_direccion) {
        direccion = _direccion
        self.irA(_direccion.siguiente(self.position()))
    }

    method irA(nuevaPosicion) {
        position = nuevaPosicion
    }
	
	method rafaga(proyectil){
				
		cargador.forEach({ bala => bala.disparateDesde(self)})
		//self.disparar(self.siguienteProyectil()) 
		cargador.clear()
		self.recargar(proyectil)	
	} 
	
	method siguienteProyectil(){
		return cargador.first()
	}
	method disparar(proyectil){
		proyectil.position(self.position().right(1) )
	}
	
	method recargar(proyectil){
		cargador.add(proyectil)
	}
	
	
}

object proyectil{
	var property position = game.at(-5,-8)
	var property potencia = 100
	
	method image(){
		return "disparo.png"	
	}
	
	method rafaga(){
		if (position.x() > 0) {			
			position = position.right(1)  
		}
	}
	
	method disparateDesde(nave){
		position = nave.position().right(1)
		
	}
	method desaparece(objeto){
		game.removeVisual(self)
		game.removeVisual(objeto)
	}
	
}

object enemigo{
	var property position = game.at(20,5)
	var property direccionesVerticales = [arriba, abajo]
	var _impactado = false
	method image(){
		if(_impactado){
			return "muerto.png"
		}else{return "enemigo1.png"}
	}
	
	method impactado(){
		_impactado = true		
	}
	method estaEnLaMismaPosicion(algo) {
		return position == algo.position()
	}
	method desaparece(objeto){
		game.removeVisual(self)
		game.removeVisual(objeto)
	}
	
	method tocameSiPodes(){
		position = self.movimientoVertical().siguiente(self.position() ) 
	}
	
	method movimientoVertical(){
		return if(0.randomUpTo(2).roundUp()  == 1) arriba else abajo 
   				 
	}
	method avanzar(){
		position = position.left(1)
	}
}

// direcciones

object izquierda {
	method siguiente(posicion) {
		return posicion.left(1)
	}
	
	method sufijo() {
		return "izq"
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
		return "arriba"
	}		
}

object abajo {
	method siguiente(posicion) {
		return posicion.down(1)
	}
	method sufijo() {
		return "abajo"
	}		
		
}
