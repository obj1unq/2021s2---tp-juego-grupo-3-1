import wollok.game.*
import personaje.*
import enemigos.*
import decorado.*

object vidaPj {
	const property position = game.at(0,11)
	method image() = "vidaPj" + personaje.vida() + ".png"
}

object avisoPuerta {
	method image() = "avisoPuerta.png"

	method mostrarse() {
		if (!monitor.estaEnElJuego(self)) {
			game.addVisualIn(self, game.at(8,10))
			game.schedule(2000, {=>
			game.removeVisual(self)})
		}			
	}
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