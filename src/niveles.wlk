import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*
import armas.*
object nivel1 {
	
	method iniciar() {
		game.addVisual(personaje)
		game.addVisual(bichoAzul)
		game.addVisual(rama)
		game.onTick(500, "Movimiento del ciclope", {=>
			bichoAzul.mover(direccionAleatoria.generar())
		})
	}
}
