import wollok.game.*
import direcciones.*
import enemigos.*
import proyectiles.*

object nave{
	var property position =game.at(0,4)
	var property cargador = [proyectil]
	var direccion
	var property _impactado = false
	
	method image(){
		return if(_impactado) "muerto.png"  else "nave1.png"
	}
	
	method impactado(){
		_impactado = true
		game.say(self,"SALVEME JEBUS")	
		game.removeTickEvent("ME MUEVO")
		
		keyboard.enter().onPressDo({game.stop()})	
	}

	method desaparece(objeto){
		game.removeVisual(self)
		game.removeVisual(objeto)
	}
	method mover(_direccion) {
        direccion = _direccion
        self.irA(_direccion.siguiente(self.position()))
    }

    method irA(nuevaPosicion) {
        position = nuevaPosicion
    }
	
	
	method abrirFuego(){
				
		cargador.forEach({ bala => bala.disparateDesde(self)})
		//self.disparar(self.siguienteProyectil()) 
		
	} 
	
	method siguienteProyectil(){
		return cargador.first()
	}
	
	method disparar(_proyectil){
		proyectil.position(self.position().right(1) )
	}
	
	method recargar(_proyectil){
		cargador.add(_proyectil)
	}
	
	
}
