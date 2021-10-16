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
