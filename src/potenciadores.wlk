import wollok.game.*
import direcciones.*


object escudo{
	var property position = game.at(18,3)
	var activado = false
	var cambioDeOrientacion = true
	
	method image(){
		return "_escudo.png"
	}
	
	method impactar(){
		activado = true	
		game.onCollideDo(self, { nave => self.implementar(nave) })	
	}
	
	method estaEnLaMismaPosicion(algo) {
	
		return position == algo.position()
	}
	
	method implementar(objeto){
		position = objeto.position()		
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
	
	method impactado(algo) {
		//vacio por polimorfismo
	}
	
}
