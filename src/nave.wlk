import wollok.game.*
import direcciones.*
import enemigos.*
import proyectiles.*
import niveles.*

object nave{
	var property position = game.at(0,4)
	var property cargador = [proyectil]
	var direccion
	var explotando = false
	var vida = 3
	
	method image(){
		return if(explotando) "muerto.png"  else "nave1.png"
	}
	
	method impactado(algo){
		if(vida > 0){vida -= 1}else{
			self.explotar()
		}
	}

//	method desaparece(objeto){
//		game.removeVisual(self)
//		game.removeVisual(objeto)
//	}
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
	
	method explotar(){
		game.say(self,"SALVEME JEBUS")	
		explotando = true
		game.schedule(600, {=> game.removeVisual(self)} )
		
		config.finalizar()
	}
	
}
