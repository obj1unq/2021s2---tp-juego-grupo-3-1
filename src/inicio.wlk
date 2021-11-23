import wollok.game.*
import musica.*
import geografia.*

object pantallaDeInicio {
	var property position = new MiPosicion(x=2, y=2)
	var num = 1
	

	method image() {
		return "inicio" + num + ".png"
	}
	
	method titilarLeyenda() {
		if (num == 1) {
			num = 2
		} else {num = 1}
	}
	
	method mostrar() {
		game.addVisual(self)
	}
}
