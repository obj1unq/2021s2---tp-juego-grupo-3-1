import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*
import armas.*
import decorado.*

object nivel1 {
	
	method iniciar() {
		game.addVisual(personaje)
		game.addVisual(bichoAzul)
		game.addVisual(rama)
		game.addVisualIn(tumba1, game.at(2, 3))
		game.addVisualIn(tumba2, game.at(4, 5))
		game.addVisualIn(tumba3, game.at(6, 7))
		game.onTick(1200, "Movimiento de bichoAzul", {=>
			bichoAzul.mover(direccionAleatoria.generar())
		})
	}
}
