import nave.*
import direcciones.*
import wollok.game.*
import enemigos.*
import proyectiles.*
import ambiente.*

object tutorial1 {
	method iniciar() {
		game.addVisual(bordeSup)
		game.addVisual(bordeInf)
		game.addVisual(nave)
		game.addVisual(proyectil)
		game.addVisual(proyectilEnemigo)
		game.addVisual(enemigo)
		config.configurarTeclas()
		config.configurarDisparo()
		config.configurarColisiones(enemigo)
		config.configurarColisiones(nave)
		config.moviendoseEnTablero()
	}

}

object config {
	method configurarTeclas(){
		keyboard.left().onPressDo( {nave.mover(izquierda) })
		keyboard.right().onPressDo({nave.mover(derecha)  })
		keyboard.up().onPressDo({ nave.mover(arriba)})
		keyboard.down().onPressDo({nave.mover(abajo)})
		keyboard.a().onPressDo({ nave.abrirFuego() })
		//keyboard.s().onPressDo({ enemigo.abrirFuego() })
	}
	
	method configurarDisparo(){
		game.onTick(100, "RAFAGA",{proyectil.saleDisparado()})
		game.onTick(100, " DISPARO ENEMIGO",{ proyectilEnemigo.saleDisparado()})
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
		game.onTick(1200, " ATAQUE ENEMIGO",{enemigo.abrirFuego()})
	}
	
}	