import wollok.game.*
import personaje.*
import armas.*
import direcciones.*
import randomizer.*
import items.*
import decorado.*
import misc.*

class EnemigoMuerto {
	const property position

	method image() = "enemigoMuerto.png"
	
	//polimorfismo
	method recibirDanio(danio) {}
	method serAgarrado() {}
}

class Enemigo{
 	var property vida 
 	var property orientacion = derecha
 	var property position = randomizer.emptyPosition()
	const nombre  
	const property danio 
	
	method image(){
		 return nombre + orientacion.sufijo() + ".png" 
	}
	
	method estaJuntoAlPersonaje() {
		return direcciones.lista().any({direccion => direcciones.estaElPersonajeHacia(direccion, position)})
    }
    
    method direccionHaciaElPersonaje() {
    	return direcciones.lista().find({direccion =>
			game.getObjectsIn(direccion.siguiente(position)).contains(personaje)
		})
    }
    
    method mirarHaciaElPersonaje() {
		orientacion = self.direccionHaciaElPersonaje()
	}
	
    method ataca() {
    	return [false, true, true, true, true].anyOne()
    }
    
    method atacar() {
    	if (self.ataca()) {
			ataqueEnemigo.atacarPersonaje(danio)
		}
    }
    
    method moverDondePueda() {
    	self.mover(direcciones.unaDireccionLibreDesde(position))
    }
    
    method mover(dir){
    	orientacion = dir
		position = dir.siguiente(position)
    }
    
    method atacarOMover() {
    	if (self.estaJuntoAlPersonaje()) {
    		self.mirarHaciaElPersonaje()
    		self.atacar()
    	} else {self.moverDondePueda()}
    }
    
    method activarExploracion() {
    	game.onTick(1250, "Exploracion de " + self.identity(),{=> 
    				self.atacarOMover()})
    }
    
    method morir() {
    	game.removeTickEvent("Exploracion de " + self.identity())
    	game.addVisual(new EnemigoMuerto(position = position))
    	fabricaDeEnemigos.removerEnemigo(self)
    	game.removeVisual(self)
    	monitor.verificarNivel()    	
    }
    
    method verificarVida() {
    	if (vida < 1) {self.morir()}
    }

	method recibirDanio(_danio) {
		//game.sound("danioEnemigo.mp3").play()
		vida = 0.max(vida - _danio)
		self.verificarVida()
	}
	
	//polimorfismo
	method serAgarrado() {}
}


object fabricaDeEnemigos {
	const enemigosDisponibles = [{self.crearBichoAzul()}, {self.crearDemon()}]
	const property enemigosCreados = []
	
	method crearDemon() {
		return new Enemigo(vida = 6,
				           danio=2,
						   nombre= "demon")
	}
	
	method crearBichoAzul() {
		return new Enemigo(vida = 3,
				           danio=1,
					       nombre= "bichoAzul")
	}
	
	method crearEnemigoAleatorio() {
		enemigosCreados.add(enemigosDisponibles.anyOne().apply())
	}
	
	method removerEnemigo(enemigo) {
		enemigosCreados.remove(enemigo)
	}
	
	method activarExploracionDeTodos() {
		enemigosCreados.forEach({enemigo => enemigo.activarExploracion()})
	}
	
	method dibujarTodos() {
		enemigosCreados.forEach({enemigo => game.addVisual(enemigo)})
	}
	
	method crearEnemigosAleatorios(cantidad) {
		cantidad.times({x => self.crearEnemigoAleatorio()})
	}
	
	method enemigosRestantes() {
		return enemigosCreados.size()
	}
}