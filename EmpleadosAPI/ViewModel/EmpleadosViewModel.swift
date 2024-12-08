//
//  EmpleadosVM.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 8/12/24.
//

import Foundation

/// ViewModel que gestiona la lógica de negocio y el estado de la vista de empleados
/// - Utiliza la macro `@Observable` para exponer propiedades reactivas a la vista
@Observable
final class EmpleadosViewModel {
	
	/// Propiedad de repositorio remoto para recuperar los datos de empleados
	let repository = RemoteRepository()
	/// Lista de `Empleado` que se obtendrán del repositorio y serán visibles en la vista
	var empleados: Empleados = []
	/// Indica si se debe mostrar un Alert de error
	var showErrorAlert = false
	/// Mensaje de error capturado en caso de fallo en la aplicación
	var errorMsg = ""
	
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

