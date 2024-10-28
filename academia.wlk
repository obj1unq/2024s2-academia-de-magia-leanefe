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
		return not self.tieneGuardada(cosa) and self.hayMuebleDondePuedoGuardar(cosa)
	}

	method hayMuebleDondePuedoGuardar(cosa) {
		return muebles.any({mueble => mueble.puedeGuardar(cosa)})
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

	method utilidad() {
		return volumen + self.utilidadPorMagia() + self.utilidadPorReliquia() + marca.utilidad()
	}

	method utilidadPorMagia() {
		return if (esMagica) 3 else 0
	}

	method utilidadPorReliquia() {
		return if (esReliquia) 5 else 0
	}
}

// MUEBLES

class Mueble {
	const property cosas = #{}
	
	method tieneGuardada(cosa) {
		return cosas.contains(cosa)
	}

	method puedeGuardar(cosa)

	method guardar(cosa) {
		cosas.add(cosa)
	}
}

class Baul inherits Mueble {
	var property volumenMaximo

	method puedeGuardar(cosa) {
		return self.tieneEspacioParaGuardar(cosa)
	}

	method tieneEspacioParaGuardar(cosa) {
		return self.volumenTotal() + cosa.volumen() <= volumenMaximo
	}

	method volumenTotal() {
		return cosas.sum({cosa => cosa.volumen()})
	}
}

class GabineteMagico inherits Mueble {

	method puedeGuardar(cosa) {
		return cosa.esMagica()
	}
}

class Armario inherits Mueble {
	var property cantidadMaxima

	method puedeGuardar(cosa) {
		return cosas.size() < cantidadMaxima
	}
}

// MARCAS
object acme {
	method utilidad(cosa) {
		return cosa.volumen() / 2
	}	
}

object fenix {
	method utilidad(cosa) {
		return if (cosa.esReliquia()) 3 else 0
	}
}

object cuchuflito {
	method utilidad(cosa) {
		return 0
	}
}