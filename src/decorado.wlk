import wollok.game.*
import niveles.*

class Decorado {
	var property image
	var property position

	method serAgarrado(){}
	method recibirDanio(danio){}
}

object puerta{
	var property nivelActual
	
	method image(){ return "puerta.png" }
	method position(){ return game.at(12, 11)}
	
	method serAgarrado(){
		nivelActual.siguienteNivel()
	}
	method recibirDanio(danio){}
}