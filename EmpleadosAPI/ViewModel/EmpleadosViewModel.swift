//
//  EmpleadosVM.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 8/12/24.
//

import Foundation

// Hay que intentar no usar @MainActor directamente en los VM y si aislar los casos
// concretos porque si por algún motivo tenemos alguna operación síncrona o algún
// cálculo interno que sea lento puede llegar a parar el hilo principal (habría que sacarlo
// a una función con async, llamarlo con await). Hay que analizar bien cada caso.
/// ViewModel que gestiona la lógica de negocio y el estado de la vista de empleados
/// - Utiliza la macro `@Observable` para exponer propiedades reactivas a la vista
@Observable
final class EmpleadosViewModel {
	
	/// Propiedad de repositorio remoto para recuperar los datos de empleados
	let repository: RepositoryProtocol // Esto también provoca DataRace si no conformamos a Sendable
	/// Lista de `Empleado` que se obtendrán del repositorio y serán visibles en la vista
	var empleados: Empleados = []
	/// Indica si se debe mostrar un Alert de error
	var showErrorAlert = false
	/// Mensaje de error capturado en caso de fallo en la aplicación
	var errorMsg = ""
	
	init(repository: RepositoryProtocol = RemoteRepository()) {
		self.repository = repository
	}
	
	// Este método se ha hecho MainActor porque la vista(que es MainActor) crea la instancia del VM(que se convierte
	// en MainActor) pero solo la instancia, porque la esta clase (y sus propiedades y métodos no lo son) por lo tanto
	// al llamar al getEMpleados desde la instancia en la vista se intenta ir del hilo principal y eso es lo que
	// causa el DataRace.
	/// Recupera la lista de `Empleado` desde el repositorio y actualiza la vista
	/// - Todas las actualizaciones de propiedades observables se realizan en el hilo principal gracias a la macro `@MainActor`
	/// - Actualiza `empleados` en caso de ir bien
	/// - Maneja errores mostrando una alerta con el mensaje de error
	@MainActor
	func getEmpleados() async {
		do {
			let empleados = try await repository.getEmpleados()
			self.empleados = empleados
		} catch {
			errorMsg = error.localizedDescription
			showErrorAlert.toggle()
		}
	}
	
}

