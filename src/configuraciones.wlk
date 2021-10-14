import wollok.game.*
import direcciones.*
import personaje.*

object config {
	
	method teclado() {
		keyboard.w().onPressDo({personaje.mover(arriba)})
		keyboard.s().onPressDo({personaje.mover(abajo)})
		keyboard.a().onPressDo({personaje.mover(izquierda)})
		keyboard.d().onPressDo({personaje.mover(derecha)})
	}
}
