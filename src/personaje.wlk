import wollok.game.*
import direcciones.*
import armas.*

object personaje {
	
	var property position = game.at(3,6)
	var property orientacion = derecha
	var vida = 10
	var ropa = "desnudo"
	var property arma = manos
	var escudo
	var conVida = true	
	method image() {
		return if(not conVida)"personajeMuerto.png"else ("pj-" + ropa + arma.sufijo() + orientacion.sufijo() + ".png")
	}
		
	method mover(direccion) { 
		self .validarEnJuego ()
		if (!direccion.esElBorde(position) && direccion.estaVacio(direccion.siguiente(position))) {
			position = direccion.siguiente(position)
		}
		orientacion = direccion
	}
	
	method posicionEnfrente() {
		return orientacion.siguiente(position)
	}
	
	
	
	method fuerzaDeAtaque() {
		return arma.danio()
	}
	
	method atacar() {
		arma.activarAtaque()
		
	}
	
	method agarrarItem() {
		game.getObjectsIn(self.posicionEnfrente()).forEach({item => item.serAgarrado()})
	}
	
	method equiparArma(_arma) {
		arma = _arma
		game.removeVisual(_arma)
	}
	
	method equiparEscudo(_escudo) {
		escudo = _escudo
		game.removeVisual(_escudo)
	}
	
	method cambiarRopa(_ropa) {
		ropa = _ropa
		game.removeVisual(_ropa)
	}
	
	method soltarArma() {
		game.addVisualIn(arma, orientacion.siguiente(position))
		arma = manos
	}
	
	method sinVida(){return vida <=1 }
	
	
	method validarEnJuego () { 
		if (not conVida) { 
			self .error ("") 
		} 
	}
	method recibirDanioDeEnemigo(danio) {
		if (self.sinVida()) {
			self.morir()
			//game.removeTickEvent(enemigo)
		} else {vida -= danio}
	}
	
	method irAUnSegundoPlano(){ position= game.at(-20,-20) }
	
	method morir() {
		 	conVida = false
		game.removeVisual(self)
		self.irAUnSegundoPlano()
	}
	
	
}
