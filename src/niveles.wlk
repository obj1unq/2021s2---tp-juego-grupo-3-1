import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*

object nivel1 {
	
	method iniciar() {
		game.addVisual(personaje)
		game.addVisual(bichoAzul)
		game.onTick(500, "Movimiento del ciclope", {=>
			bichoAzul.mover(direccionAleatoria.generar())
		})
	}
}
