import nave.*
import direcciones.*
import wollok.game.*

object tutorial1 {
	method iniciar() {
		game.addVisual(nave)
		game.addVisual(proyectil)
		game.addVisual(enemigo)
		config.configurarTeclas()
		config.configurarDisparo()
		config.configurarColisiones(enemigo)
		config.moviendoseEnTablero()
	}

}

object config {
	method configurarTeclas(){
		keyboard.left().onPressDo( {nave.mover(izquierda) })
		keyboard.right().onPressDo({nave.mover(derecha)  })
		keyboard.up().onPressDo({ nave.mover(arriba)})
		keyboard.down().onPressDo({nave.mover(abajo)})
		keyboard.a().onPressDo({ nave.rafaga(proyectil) })
	}
	
	method configurarDisparo(){
		game.onTick(100, "RAFAGA",{proyectil.rafaga()})
		//game.onTick(200,"EXPLOSION",{enemigo.desaparece()})
	}
	
	 method configurarColisiones(objeto){
		game.onCollideDo( objeto ,{ algo =>  
			objeto.impactado();
			game.schedule(1000,{=> objeto.desaparece(algo)})
		} )
		
		
		//game.onCollideDo(proyectil, {algo => algo.desaparece()})
	 }
		
	method moviendoseEnTablero(){
		game.onTick(800, "ME MUEVO", { enemigo.tocameSiPodes();enemigo.avanzar()})
	}
	
}	