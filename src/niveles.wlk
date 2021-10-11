import nave.*
import direcciones.*
import wollok.game.*
import enemigos.*
import proyectiles.*
import ambiente.*
import potenciadores.*


object tutorial1 {
	method iniciar() {
		game.sound("musica.mp3")
		game.addVisual(bordeSup)
		game.addVisual(bordeInf)
		game.addVisual(nave)
		game.addVisual(proyectil)
		game.addVisual(proyectil1)
		game.addVisual(proyectilEnemigo)
		game.addVisual(enemigo)
		game.addVisual(escudo)
		
		
		config.configurarTeclas()
		config.configurarDisparo()
		config.configurarPotenciadores()
		config.configurarColisiones(nave)
		config.configurarColisiones(proyectil)
		config.configurarColisiones(proyectil1)
		config.configurarColisiones(proyectilEnemigo)
		config.configurarColisiones(enemigo)
		config.configurarColisiones(escudo)
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
	
	method configurarPotenciadores(){
		game.onTick(600, "potenciador",{escudo.tocameSiPodes();escudo.avanzar()})
	}
	
	method configurarDisparo(){
		game.onTick(100, "RAFAGA",{proyectil.saleDisparado();proyectil1.saleDisparado()})
		game.onTick(100, "DISPARO ENEMIGO",{ proyectilEnemigo.saleDisparado()})
		//game.onTick(200,"EXPLOSION",{enemigo.desaparece()})
	}
	
	 method configurarColisiones(objeto){
		game.onCollideDo( objeto ,{ algo =>  
			objeto.impactado(algo);
//			game.schedule(1000,{=> objeto.desaparece(algo)})
		} )
		
		
		//game.onCollideDo(proyectil, {algo => algo.desaparece()})
	 }
	 
		
	method moviendoseEnTablero(){
		game.onTick(800, "ME MUEVO", { enemigo.tocameSiPodes();enemigo.avanzar()})
		game.onTick(1200, " ATAQUE ENEMIGO",{enemigo.abrirFuego()})
	}
	
	method finalizar() {
		game.addVisualIn(self, game.center())
		game.onTick(500, "EXIT", {=> game.say(self,"Presione Enter Para salir")} )
		keyboard.enter().onPressDo({game.stop()})	
		
	}
	
}	