import wollok.game.*
import personaje.*
import armas.*
import geografia.*
import randomizer.*
import items.*
import decorado.*
import misc.*

class EnemigoMuerto {
	var property position
	
	method verificarPosicion() {
		if (direcciones.frenteALaPuerta(position)) {
			direcciones.unaDireccionLibreDesde(position).avanzarUno(position)
		}
	}
	
	method image() = "enemigoMuerto.png"
	
	//polimorfismo
	method recibirDanio(danio, direccion) {}
	method serAgarrado() {}
}

class Enemigo {
 	var property vida 
 	var property orientacion = derecha
 	var property position = randomizer.emptyPosition()
	const nombre  
	const property danio 
	
	method image(){
		 return nombre + orientacion.sufijo() + ".png" 
	}
	
	method estaJuntoAlPersonaje() {
		return direcciones.lista().any({direccion => direcciones.estaElPersonajeHacia(direccion.siguiente(position))})
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
			ataqueEnemigo.atacarPersonaje(danio, orientacion)
		}
    }
    
    method moverDondePueda() {
    	const newDir = direcciones.aleatoria()
    	if (self.puedeMover(newDir)) {
    		self.mover(newDir)
    	} else {self.moverDondePueda()}
    }
    
    method puedeMover(dir) {
    	return direcciones.estaLibre(dir.siguiente(position))
    }
    
    method mover(dir){
    	orientacion = dir
		dir.avanzarUno(position)
    }
    
    method retrocederSiPuede(direccion) {
    	if (self.puedeMover(direccion)) {
    		direccion.avanzarUno(position)
    	}
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
    
    method drop() {
		return {
				const enemigoMue = new EnemigoMuerto(position = position.clone())
   				enemigoMue.verificarPosicion()
   				game.addVisual(enemigoMue)
   				}
    }
    
    method morir() {
    	game.removeTickEvent("Exploracion de " + self.identity())
    	self.drop().apply()
    	fabricaDeEnemigos.removerEnemigo(self)
    	game.removeVisual(self)
    	monitor.verificarNivel() 
    }
    
    method verificarVida() {
    	if (vida < 1) {self.morir();}
    }

	method restarVida(_danio){
		vida = 0.max(vida - _danio)
		self.verificarVida()
	}

	method recibirDanio(_danio, direccion) {
		game.sound("danioEnemigo.mp3").play()
		self.retrocederSiPuede(direccion)
		self.restarVida(_danio)
	}
	
	//polimorfismo
	method serAgarrado() {}
}


class EnemigoConDrop inherits Enemigo {

	method numAl() {
		return [1, 0, 0, 1, 0].anyOne()
	}
	
	method dropDePocion() {
		return {
				const poc = new Pocion(position = position.clone());
				poc.verificarPosicion();
				game.addVisual(poc);
				}
	}
	
	override method drop() {
		return [super(), self.dropDePocion()].get(self.numAl())
	}
}

object fabricaDeEnemigos {
	const enemigosDisponibles = [{self.crearEsqueleto()}, {self.crearDemon()}]
	const property enemigosCreados = []
	
	method crearDemon() {
		return new Enemigo(vida = 6,
				           danio=2,
						   nombre= "demon")
	}
	
	method crearMomia() {
		return new Enemigo(vida = 5,
				           danio=2,
						   nombre= "momia")
	}
	
	
	method crearEsqueleto() {
		return new EnemigoConDrop(vida = 4,
						   		  danio = 2,
						   		  nombre = "esqueleto"	
		)
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
	
	method removerYBorrar(enemigo) {
		game.removeVisual(enemigo)
		enemigosCreados.remove(enemigo)
	}
	
	method removerYBorrarTodos() {
		enemigosCreados.forEach({enemigo => self.removerYBorrar(enemigo)})
	}
}