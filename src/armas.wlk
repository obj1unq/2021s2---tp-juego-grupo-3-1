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
	
	//metodos de relleno para polimorfismo
	method serAgarrado(){}
	
}

object arco{
	var property position = game.at(10, 10)
	var property carga = 1

	method image() = "arco.png"
	
	method sufijo() {
		return "-arco"
	}
	
	method danio() {
		return 0
	}
	
	method activarAtaque() {
		if(carga > 0){
			carga -= 1
			new Flecha().disparar()			
		}
		
	}
	
	method recibirDanio(danio){}
	
	method serAgarrado() {
		personaje.equiparArma(self)
	}
	
	method recargar(){
		carga += 1
	}
}

class Flecha{
	var property position = personaje.posicionEnfrente()
	var property orientacion = personaje.orientacion()
	var distancia = 4
	
	method image() = "flecha"+ orientacion.sufijo() +".png"
	
	
	method danio(){
		return 1
	}
	
	method sufijo() {

	}
	
	method disparar(){
		game.addVisual(self)
		game.onTick(100, "flecha", {
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
		game.removeTickEvent("flecha")
		arco.recargar()
	}
	
	method recibirDanio(danio){}
		
		method mover(direccion){
		self.irA(direccion.siguiente(self.position()))
	}
	
	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}
	
}
