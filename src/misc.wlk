import wollok.game.*
import personaje.*
import enemigos.*
import decorado.*
import geografia.*

object vidaPj {
	const property position = new MiPosicion(x = 0, y = 11)
	method image() = "vidaPj" + personaje.vida() + ".png"
}

object avisoPuerta {
	const property position = new MiPosicion(x = 8, y = 10)
	method image() = "avisoPuerta.png"

	method mostrarse() {
		if (!monitor.estaEnElJuego(self)) {
			game.addVisual(self)
			game.schedule(2000, {=>
			game.removeVisual(self)})
		}			
	}
	
	//polimorfismo
	method serAgarrado(){}
	method recibirDanio(danio, direccion) {}
}

object monitor {
	
	method hayEnemigosRestantes() {
		return fabricaDeEnemigos.enemigosRestantes() > 0
	}
	
	method verificarNivel() {
		if (!self.hayEnemigosRestantes()) {
			puerta.abrir()
		}
	}

	method validarEnemigosRestantes(accion){
		if(self.hayEnemigosRestantes()) {
			avisoPuerta.mostrarse()
		} else {accion.apply()}
	}

	method estaEnElJuego(objeto) {
		return game.hasVisual(objeto)
	}
}