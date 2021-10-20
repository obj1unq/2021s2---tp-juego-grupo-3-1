import wollok.game.*
import musica.*

object pantallaDeInicio {
	var property position = game.at(2,2)
	var num = 1
	
	method image() {
		if (num == 1) {game.schedule(800, {=>num = 2})}
			else {game.schedule(800, {=>num = 1})}
		return "inicio" + num + ".png"
	}
	
	method mostrar() {
		game.addVisual(self)
	}
}
