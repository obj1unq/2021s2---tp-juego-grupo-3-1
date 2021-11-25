import wollok.game.*
import niveles.*
import misc.*

class Decorado inherits Polimorfi {
	var property image
	var property position
}

object puerta {
	var property nivelActual
	var property position = game.at(12,11)
	var imagen
	
	method image() = imagen
	
	method serAgarrado(){
		monitor.validarEnemigosRestantes({nivelActual.siguienteNivel()})
	}
	
	method cerrar() {
		imagen = "puertaCerrada.png"
	}
	
	method abrir() {
		game.schedule(50,{=> game.sound("nivelCompletado.mp3").play()})
		imagen = "puertaAbierta.png"
	}
	
	//polimorfismo
	method recibirDanio(danio, direccion) {}
}

object fondo inherits Polimorfi {
	var property image = "background.jpg"
	method position(){ return game.at(0, 0)}
}