import wollok.game.*
import personaje.*
import armas.*
import direcciones.*
import randomizer.*
import items.*

class Enemigo{
	var property position
 	var  property vida 
 	var property orientacion = derecha
	const property nombre  
	const property danio 
	//var property modo = caminante
	var property imagenDelEnemigo = nombre + orientacion.sufijo() + ".png" 
	const drop 
	method image(){ 
		 return  imagenDelEnemigo 
	}
	
	method dibujarse(){game.addVisual(self)}
	
	method recibirDanio(_danio) {
		if (vida - _danio <= 0) {
			self.morir()
		} else {vida -= _danio}
	}

	
	method morir() {
		game.removeTickEvent("Movimiento de " + self.identity())
		game.removeVisual(self)
		self.dropear()
			
	}
	method dropear(){
		const posibilidadDeDejarObjeto = (0..9).anyOne()
		if(posibilidadDeDejarObjeto > 7){
			self.dejarCaerItem()
		}
	}
	
	method dejarCaerItem(){
		if(drop){
			game.addVisual(new Item(position =self.position()))
		}
	}
	
	method moverConstantemente(){
		game.onTick(1200,"Movimiento de " + self.identity(), {=>self.atacarOMovilizar(direccionAleatoria.generar())})
		
	}
	
	
	method personajeEstaCerca(){
		// hacer esto con un any
		return self.personajeCerca(arriba) or self.personajeCerca(abajo) or self.personajeCerca(izquierda) or self.personajeCerca(derecha) 
	}
	
	method personajeCerca(_direccion){
		orientacion= _direccion
		return personaje.position() == _direccion.siguiente(position)
	} 

	method atacarOMovilizar(direccion){
		if(self.personajeEstaCerca()){
		   self.pasarAModoDeCombate()
		}else{ self.pasarAModoCaminante(direccion)}
	}
	
	method pasarAModoCaminante(direccion){
		const modo= caminante
		modo.accion(direccion,self)
	}
	
	method pasarAModoDeCombate(){
		const modo= combate
		game.schedule(1000,{=> 
			// mover esto a otro metodo
			imagenDelEnemigo=nombre + orientacion.sufijo()+ modo.imagenDeAccion() + ".png"; 
			// mover esto a otro metodo
			if(self.personajeEstaCerca()){modo.atacar(danio)}
		})
		imagenDelEnemigo = nombre + orientacion.sufijo() + ".png"
		
	}
	

}






// ARAÑAS


//Modos de accion de los enemigos	


object combate{
	
	
	method atacar(danio){  personaje.recibirDanioDeEnemigo(danio)}
	
	method activarAtaques(danio){
		game.schedule(1000,{=> self.atacar(danio)})
	}
	
	method imagenDeAccion(){
		return "_ataque_Fuerte"
	}
	
	method accion(direccion,enemigo){}

}

object caminante{
	
	method puedeMover(direccion,enemigo) {
		return !direccion.esElBorde(enemigo.position()) && direccion.estaVacio(direccion.siguiente(enemigo.position()))
	}
	
	
	method accion(direccion,enemigo) {
		if (self.puedeMover(direccion,enemigo)) {
		// esta parte la tengo que pasar a una subtarea
		// esto es responsabilidad del enemigo
			enemigo.position(direccion.siguiente(enemigo.position())) 
			enemigo.orientacion(direccion)
			enemigo.imagenDelEnemigo (enemigo.nombre() + enemigo.orientacion().sufijo() + ".png") 
		} else if (self.puedeMover(direccion.opuesto(),enemigo)) {
			// esta tambien
			// esto es responsabilidad del enemigo
			enemigo.position (direccion.opuesto().siguiente(enemigo.position()))
			enemigo.orientacion (direccion.opuesto())
			enemigo.imagenDelEnemigo (enemigo.nombre() + enemigo.orientacion().sufijo() + ".png") 
		}
	}
	
	method atacar(danio){}
	method imagenDeAccion(){}
}


object crearDemon{
	method crearNuevoEnemigo(){
		return new Enemigo(vida = 6,danio=2,drop = false, nombre= "demon", position = randomizer.emptyPosition() )
	}
	}
object crearBicho{	
	method crearNuevoEnemigo(){
		return new Enemigo(vida = 3,danio=1,drop = true, nombre= "bichoAzul", position = randomizer.emptyPosition() )
	}
	
}

object creadorDeEnemigos{
	const enemigos= #{}
	const factoriesEnemigos= [crearDemon, crearBicho]
	
		//method dibujarEnemigos(){
//		enemigos.forEach({enemigo => enemigo.dibujarse()})
//	}
//	
	
	method moverATodos(){
		enemigos.forEach({enemigo => enemigo.moverConstantemente()})
		 
	}
	

	method  generarNuevoEnemigo() { 
		const indiceAleatorio = ( 0  .. factoriesEnemigos.size () - 1 ) .anyOne () 
		 const factory = factoriesEnemigos.get (indiceAleatorio) 
		 return factory.crearNuevoEnemigo()
	}
	
	method dibujarEnemigos(cantidad){
		cantidad.times({ x => enemigos.add(self.generarNuevoEnemigo())})
		enemigos.forEach({enemigo => enemigo.dibujarse()})
	}
	
	
}