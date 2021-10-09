import wollok.game.*
import main.*
import posiciones.*

object config {

	method configurarTeclas() {
		keyboard.left().onPressDo( { main.mover(izquierda)  })
		keyboard.right().onPressDo({ main.mover(derecha) })
		keyboard.up().onPressDo({ main.mover(arriba) })
		keyboard.down().onPressDo({ main.mover(abajo) })
	}
	
	method configurarGravedad() {
		// game.onTick(800, "GRAVEDAD", { pepita.caerSiPodes() })
		
//		Si lo quiero frenar
//		game.removeTickEvent("GRAVEDAD")
	}

	method configurarColisiones() {
		// game.onCollideDo(pepita, {algo => algo.teEncontro(pepita)})

//		game.onCollideDo(nido, { personaje => personaje.ganar()})
//		game.onCollideDo(silvestre, { personaje => personaje.perder()})
	}

}