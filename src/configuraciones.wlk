import wollok.game.*
import direcciones.*
import personaje.*
import armas.*
import niveles.*
import inicio.*
import misc.*

object config {
	
	method teclado() {
		keyboard.w().onPressDo({if (monitor.estaEnElJuego(personaje)) {personaje.mover(arriba)}})
		keyboard.s().onPressDo({if (monitor.estaEnElJuego(personaje)) {personaje.mover(abajo)}})
		keyboard.a().onPressDo({if (monitor.estaEnElJuego(personaje)) {personaje.mover(izquierda)}})
		keyboard.d().onPressDo({if (monitor.estaEnElJuego(personaje)) {personaje.mover(derecha)}})
		keyboard.k().onPressDo({if (monitor.estaEnElJuego(personaje)) {personaje.agarrarItem()}})
     	keyboard.j().onPressDo({if (monitor.estaEnElJuego(personaje)) {personaje.atacar()}})
	}
	
}
