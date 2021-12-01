import wollok.game.*

object musica {
	const property pantallaInicio = game.sound("pantallaInicio.mp3")
	const property general = game.sound("general.mp3")
	const property nivelFinal = game.sound("nivelFinal.mp3")
	
	method loopear(tema) {
		tema.shouldLoop(true)
		tema.play()
	}
	
	method detener(tema) {
		tema.stop()
	}
}
