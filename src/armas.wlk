import wollok.game.*
import personaje.*
import direcciones.*

object rama{
	var property position = game.at(5,4)
	method image() = "rama.png"
	
	method sufijo() {
		return "-rama"
	}
	
	method danio() {
		return 2
	}
	
	method activarAtaque() {
		ataqueCercano.atacar()		
	}
	
	method recibirDanio(danio){}
	
	method serAgarrado() {
		personaje.equiparArma(self)
	}
}

object manos {
	
	method sufijo() {
		return ""
	}
	
	method danio() {
		return 1
	}
	
	method activarAtaque() {
		ataqueCercano.atacar()
	}
	method serAgarrado() {}	
}

object ataqueCercano {
	
	method image() = "ataque" + personaje.arma().sufijo() + personaje.orientacion().sufijo() + ".png"
	
	method atacar() {
		game.addVisualIn(self, personaje.posicionEnfrente())
		game.onCollideDo(self, {enemigo => enemigo.recibirDanio(self.danio())})
		game.schedule(50, {=> game.removeVisual(self)})
	}
	
	method danio() {
		return personaje.fuerzaDeAtaque()
	}
	
	method serAgarrado(){}
}

class ArmaADistancia{
	const arma = arco
	var property position = game.at(1.randomUpTo(10), 1.randomUpTo(10))
		
	method image() = arma.toString() +".png"

	method sufijo() {
		return "-" + arma.toString()
	}

	method activarAtaque() {
			arma.activarAtaque()			
			
	}
		
	method serAgarrado() {
		personaje.equiparArma(self)
	}
	
	method recibirDanio(danio){}
	

}

object arco{
	var property position = personaje.position()
	var property carga = 1

	method danio() {
		return 0
	}
	
	method activarAtaque() {
		if(carga > 0){
			carga -= 1
			new Municion(municion = new Flecha()).disparar()			
		}	
	}
	
	method recibirDanio(danio){}
	
	method recargar(){
		if(carga == 0) {carga += 1}
	}
}

object baculo{
	var property position = personaje.position()
	var property carga = 1

	method danio() {
		return 0
	}
	
	method activarAtaque() {
		if(carga > 0){
			carga -= 1
			new Municion(municion = new BolaDeFuego()).disparar()			
		}	
	}
	
	method recibirDanio(danio){}
	
	method recargar(){
		if(carga == 0) {carga += 1}
	}
}

class Municion{
	var property position = personaje.position()
	var property orientacion = personaje.orientacion()
	var distancia = 4
	const property municion = new Flecha()

	method image() = municion.image()	
	
	method danio() = municion.danio()
		
	method disparar(){
		game.addVisual(self)
		game.onTick(100, municion.toString(), {
			game.onCollideDo(self, {enemigo => enemigo.recibirDanio(self.danio()) self.borrar()})
			self.mover(orientacion)
			distancia -= 1
			if(distancia < 0){
				self.borrar()
			}
		})
	}
	
	method borrar(){
		game.removeVisual(self)
		game.removeTickEvent(municion.toString())
		arco.recargar()
		baculo.recargar()
	}
	
	method recibirDanio(danio){}
		
		method mover(direccion){
		self.irA(direccion.siguiente(self.position()))
	}
	
	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}
	
}
class Flecha {
	var property orientacion = personaje.orientacion()
	method image() = "flecha"+ orientacion.sufijo() +".png"
	
	method danio(){
		return 1
	}

}

class BolaDeFuego inherits Flecha{

	override method image() = "bolaDeFuego"+ orientacion.sufijo() +".png"
	
	override method danio(){
		return 2
	}

}