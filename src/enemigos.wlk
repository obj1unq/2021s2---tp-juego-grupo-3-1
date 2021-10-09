import wollok.game.*
import direcciones.*
import proyectiles.*

object enemigo{
	var property position = game.at(18,5)
	var _impactado = false
	var cambioDeOrientacion = true
	var property cargador =[proyectilEnemigo]
	
	method image(){
		return if(_impactado) "muerto.png" else "enemigo1.png"
	}
	
	method impactado(){
		_impactado = true		
	}
	
	method estaEnLaMismaPosicion(algo) {
	
		return position == algo.position()
	}
	
	method desaparece(objeto){
		game.removeVisual(proyectilEnemigo)
		game.removeVisual(self)
		game.removeVisual(objeto)
	}
	
	
	method tocameSiPodes(){
		position = self.movimientoVertical().siguiente(self.position() ) 
	}
	
	method movimientoVertical(){
	//	return if(0.randomUpTo(2).roundUp() -1 == 1) arriba else abajo 
   		
   		if(cambioDeOrientacion){
   			cambioDeOrientacion = false
   			return arriba
   			}else{ cambioDeOrientacion = true return abajo } 		 
	}
	
	method avanzar(){
		position = position.left(1)
	}
	
		method abrirFuego(){
			
				cargador.forEach({ bala => bala.disparateDesdeEnemigo(self)})
		//self.disparar(self.siguienteProyectil()) 
		}
	
}
