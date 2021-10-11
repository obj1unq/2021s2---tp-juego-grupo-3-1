import wollok.game.*
import characters.*
import direcciones.*
import armas.*

object configuraciones {
	
	method teclado() {
		keyboard.w().onPressDo({jill.moverVertical(arriba)})
		keyboard.s().onPressDo({jill.moverVertical(abajo)})
		keyboard.d().onPressDo({jill.moverHorizontal(derecha)})
		keyboard.a().onPressDo({jill.moverHorizontal(izquierda)})
		keyboard.j().onPressDo({jill.disparar(balaDeJill)})
				
	}
	
	method movimientoZombies() {
		game.onTick(1300, "Movimiento zombie1", { => zombie1.mover(izquierda)})
	}
	
	method animarPersonajes() {
		game.onTick(200, "Animacion zombie1", {=> 
			zombie1.refrescarImagen();
			jill.refrescarImagen();
		})
	}
	
	
	
}
