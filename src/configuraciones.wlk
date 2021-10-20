import wollok.game.*
import direcciones.*
import personaje.*
import armas.*
import niveles.*
import inicio.*

object config {
	
	method teclado() {
		keyboard.w().onPressDo({personaje.mover(arriba)})
		keyboard.s().onPressDo({personaje.mover(abajo)})
		keyboard.a().onPressDo({personaje.mover(izquierda)})
		keyboard.d().onPressDo({personaje.mover(derecha)})
		keyboard.k().onPressDo({personaje.agarrarItem()})
		keyboard.p().onPressDo({personaje.soltarArma()})
		keyboard.j().onPressDo({personaje.atacar()})
	}
	
}
