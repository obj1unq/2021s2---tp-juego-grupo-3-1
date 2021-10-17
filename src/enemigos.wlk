import wollok.game.*
import personaje.*
import armas.*
import direcciones.*

class Enemigo {
	var property position
 	var vida 
 	var orientacion = derecha
	var nombre  
	var damage 
	var imagen 
	method image() = imagen + orientacion.sufijo() + ".png"
	
	method dibujarse(){game.addVisual(self)}
	
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
		game.onTick(1200,nombre, {=>self.atacarOMovilizar(direccionAleatoria.generar())})
		
	}
	
	method puedeMover(direccion) {
		return !direccion.esElBorde(position) && direccion.estaVacio(direccion.siguiente(position))
	}
	
	method puedeAtacar(){
		return self.personajeCerca(arriba) or self.personajeCerca(abajo) or self.personajeCerca(izquierda) or self.personajeCerca(derecha) 
	}
	// este metodo mira en la celda siguiente esta posicionado el personaje
	method personajeCerca(_direccion){
		orientacion= _direccion
		return personaje.position() == _direccion.siguiente(position)
	} 

	method atacarOMovilizar(direccion){
		if(self.puedeAtacar()){
			self.atacar()
		}else{self.mover(direccion)}
	}

	method atacar(){ personaje.recibirDanio(damage)}
	
	//metodos de relleno para polimorfismo
	method serAgarrado(){}
	
	
	
}

object creadorDeEnemigos{
	
	const bicho1= new Enemigo(position = game.at(12,8),vida=3,nombre="bichoAzul",damage= 2,imagen="bichoAzul" )
	const bicho2= new Enemigo(position = game.at(9,3),vida=3,nombre="bichoAzul1",damage= 2,imagen="bichoAzul"  )
	const demon= new Enemigo(position = game.at(5,8),vida=6,nombre="demon",damage= 4,imagen="demon" )
	const demon1= new Enemigo(position = game.at(1,5),vida=6,nombre="demon1",damage= 4,imagen="demon")
	
	var enemigos= [bicho1,bicho2, demon, demon1]

	
	method dibujarEnemigos(){
		enemigos.forEach({enemigo => enemigo.dibujarse()})
	}
	
	method moverATodos(){
		enemigos.forEach({enemigo => enemigo.moverConstantemente()})
		 
	}
	
}