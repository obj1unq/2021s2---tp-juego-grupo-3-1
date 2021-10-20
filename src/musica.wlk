import wollok.game.*

object musica {
	const property pantallaInicio = game.sound("pantallaInicio.mp3")
	const property nivel1 = game.sound("nivel1.mp3")
	
	method loopear(tema) {
		tema.shouldLoop(true)
		tema.play()
	}
}
