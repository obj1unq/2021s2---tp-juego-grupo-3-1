import wollok.game.*
import niveles.*
import misc.*

class Decorado {
	var property image
	var property position

	method serAgarrado(){}
	method recibirDanio(danio){}
}

object puerta{
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
		game.onTick(1,"sonido",{ game.sound("nivelCompletado.mp3").play() })
		game.removeTickEvent("sonido")
		imagen = "puertaAbierta.png"
	}
	
	//polimorfismo
	method recibirDanio(danio){}

}

object fondo{
	var property image = "background.jpg"
	method position(){ return game.at(0, 0)}
}