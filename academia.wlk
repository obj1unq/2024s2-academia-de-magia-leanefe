// ACADEMIA

object academia {
	var property muebles = #{}

	method tieneGuardada(cosa) {
		return muebles.any({mueble => mueble.tieneGuardada(cosa)})
	}

	method muebleQueContiene(cosa) {
		self.validarExistenciaEnAcademia(cosa)
		return muebles.find({mueble => mueble.tieneGuardada(cosa)})
	}

	method validarExistenciaEnAcademia(cosa) {
		if(not self.tieneGuardada(cosa)) 
			self.error("El objeto no está en la academia.")
	}

	method puedeGuardar(cosa) {
		return not self.tieneGuardada(cosa) and muebles.any({mueble => mueble.puedeGuardar(cosa)})
	}

	method mueblesDondePuedoGuardar(cosa) {
		self.validarSiPuedeGuardar(cosa)
		return muebles.filter({mueble => mueble.puedeGuardar(cosa)})
	}

	method validarSiPuedeGuardar(cosa) {
		if (not self.puedeGuardar(cosa))
			self.error("No puede guardarse el objeto en la academia.")
	}

	method guardar(cosa) {
		self.mueblesDondePuedoGuardar(cosa).anyOne().guardar(cosa)
	}
}

// COSAS

class Cosa {
	const property marca
	const property volumen 
	const property esMagica
	const property esReliquia	
}

// MUEBLES

class Mueble {
	const property cosas = #{}
	
	method tieneGuardada(cosa) {
		return cosas.contains(cosa)
	}

	method guardar(cosa) {
		cosas.add(cosa)
	}
}

object baul inherits Mueble {
	var volumen = 0
	var property volumenMaximo = 5
	
	override method guardar(cosa) {
		super(cosa)
		volumen += cosa.volumen()
	}

	method volumen() {
		return volumen
	}

	method puedeGuardar(cosa) {
		return self.tieneEspacioParaGuardar(cosa)
	}

	method tieneEspacioParaGuardar(cosa) {
		return volumen + cosa.volumen() <= volumenMaximo
	}
}

object gabineteMagico inherits Mueble {

	method puedeGuardar(cosa) {
		return cosa.esMagica()
	}
}

object armario inherits Mueble {
	var property cantidadMaxima = 3 

	method puedeGuardar(cosa) {
		return cosas.size() < cantidadMaxima
	}
}

// MARCAS
object acme {
	method volumenQueAporta(cosa) {

	}	
}

object fenix {
	method volumenQueAporta(cosa) {

	}
}

object cuchuflito {
	method volumenQueAporta(cosa) {

	}
}