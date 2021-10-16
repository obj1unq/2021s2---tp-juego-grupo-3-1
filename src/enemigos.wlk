import wollok.game.*
import personaje.*
import armas.*
import direcciones.*

class Bicho {
	var property position = game.at(5, 7)
 	var vida = 6
 	var orientacion = derecha
	var nombre = "bichoAzul"
	var damage = 1
	method image() = "bichoAzul" + orientacion.sufijo() + ".png"
	
	method recibirDanio(danio) {
		if (vida - danio <= 0) {
			self.desaparecer()
		} else {vida -= danio}
	}
	
	method desaparecer() {
		game.removeVisual(self)
	}
	
	method mover(direccion) {
		if (self.puedeMover(direccion)) {
			position = direccion.siguiente(position)
			orientacion = direccion
		} else if (self.puedeMover(direccion.opuesto())) {
			position = direccion.opuesto().siguiente(position)
			orientacion = direccion.opuesto()
		}
	}
	
	method moverConstantemente(){
		// evento que les dice a los bichos que se muevan
		game.onTick(1200,nombre, {=>self.mover(direccionAleatoria.generar())})
		// evento que ñle dice a los bichos que ataquen si pueden
		game.onTick(200,"atacar",{=>self.atacarSiPuede(personaje)})
	}
	
	method puedeMover(direccion) {
		return !direccion.esElBorde(position) && direccion.estaVacio(direccion.siguiente(position))
	}
	
	method puedeAtacar(){
		return self.presa(arriba) or self.presa(abajo) or self.presa(izquierda) or self.presa(derecha) 
	}
	// este metodo mira en la celda siguiente esta posicionado el personaje
	method presa(_direccion){
		return personaje.position() == _direccion.siguiente(position)
	} 

	// Aqui deberia parar 1 sola vez el evnto y comenzar a atacar 
	method atacarSiPuede(enemigo){
			
		if(self.puedeAtacar() ){
			game.removeTickEvent(nombre)
			// solo hay que agragar el metodo al personaje
			enemigo.recibirDanio(damage)
		}
	}
			

		
		
	
	
	
	//metodos de relleno para polimorfismo
	method serAgarrado(){}
	
	
	
}

object creadorDeEnemigos{
	
	const bicho1= new Bicho(position = game.at(5,8), nombre= "bichoAzul")
	const bicho2= new Bicho(position = game.at(9,9), nombre= "bichoAzul1" )
	var bichos= [bicho1,bicho2]
	var position 
	var property image 
	
	
	method dibujarBichos(){
		game.addVisual(bicho1)
		game.addVisual(bicho2)
	}
	
	method crear(_position,_nombre){
		return (new Bicho(position =_position,nombre =_nombre))
	}
	
	method moverATodos(){
		bichos.forEach({bicho => bicho.moverConstantemente()})
		 
	}
	
}