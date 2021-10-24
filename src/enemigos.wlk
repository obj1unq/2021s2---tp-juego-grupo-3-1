import wollok.game.*
import personaje.*
import armas.*
import direcciones.*
import randomizer.*
import items.*


// DEMON
class Demon {
	var property position
 	var vida = 6 
 	var orientacion = derecha
	const nombre = "demon" 
	const damage = 2
	var atacando= false
	
	method image(){ 
		return if(atacando) self.mostrarMovimientoEnAtaque() else nombre + orientacion.sufijo() + ".png"
		
	}
	
	method dibujarse(){game.addVisual(self)}
	
	method recibirDanio(danio) {
		if (vida - danio <= 0) {
			self.morir()
		} else {vida -= danio}
	}
	
	method llevarAUnSegundoPlano(pos){
		var posicion = pos
		posicion= game.at(-10,-10)
	}
	
	method morir() {
		game.removeVisual(self)
		self.llevarAUnSegundoPlano(position)
		//game.removeTickEvent("Movimiento de " + nombre)
		
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
		game.onTick(1200,"Movimiento de " + nombre, {=>self.atacarOMovilizar(direccionAleatoria.generar())})
		
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
		}else{atacando =false  ; self.mover(direccion)}
	}

	method atacar(){atacando =true ; personaje.recibirDanioDeEnemigo(damage)}
	
// A mejorar	
	method mostrarMovimientoEnAtaque(){
		var imagenAMostrar = nombre + orientacion.sufijo() + ".png"
		const indiceAleatorio = (0..2).anyOne()	
		if  (indiceAleatorio == 1){
			imagenAMostrar = nombre + orientacion.sufijo() +"_ataque_fuerte.png"
			}
			return imagenAMostrar
	}
	
	//metodos de relleno para polimorfismo
	method serAgarrado(){}
	
	method dropear(){}
}

// ARAÑAS
class Bicho {
	var property position
 	var vida =2
 	var orientacion = derecha
	const nombre = "bichoAzul"  
	const damage = 1
	var atacando = false
	
	method image() = nombre + orientacion.sufijo() + ".png"
	
	method dibujarse(){game.addVisual(self)}
	
	method recibirDanio(danio) {
		if (vida - danio <= 0) {
			self.morir()
		} else {vida -= danio}
	}
	
	method llevarAUnSegundoPlano(pos){
		var posicion = pos
		posicion= game.at(-10,-10)
	}
	
	method morir() {
		game.removeVisual(self)
		self.dropear()
		self.llevarAUnSegundoPlano(position)
		//game.removeTickEvent("Movimiento de " + nombre)
		
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
		game.onTick(1200,"Movimiento de " + nombre, {=>self.atacarOMovilizar(direccionAleatoria.generar())})
		
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
		}else{atacando =false  ; self.mover(direccion)}
	}

	method atacar(){atacando =true ; personaje.recibirDanioDeEnemigo(damage)}
	
	//metodos de relleno para polimorfismo
	method serAgarrado(){}
	 method dejarCaerItem(){
	 	game.addVisual(new Item(position = position))
	 }
	
	method dropear(){
		const posibilidadDeDejarObjeto = (0..9).anyOne()
		if(posibilidadDeDejarObjeto > 7){
			self.dejarCaerItem()
		}
	}
	
}


object dominioFactory{
	 method crearNuevoEnemigo(){
		return new Demon(position = randomizer.emptyPosition())		
	}
	
}

object bichoFactory{
	 method crearNuevoEnemigo(){
		return new Bicho(position = randomizer.emptyPosition())
	}
	
}


object creadorDeEnemigos{
	const enemigos= #{}
	const factoriesEnemigos= [bichoFactory, dominioFactory]
	
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