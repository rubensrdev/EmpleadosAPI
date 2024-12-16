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
	/// Propiedad calculada que agrupa una lista de empleados por su departamento.
	///
	/// Utiliza el inicializador `Dictionary(grouping:by:)` para crear un diccionario donde cada clave es
	/// un valor de tipo `Empleado.Departamento` y el valor asociado es un array de `[Empleado]
	/// con todos los empleados de ese departmento
	var empleadosDepartamento: [Empleado.Departamento : [Empleado]] {
		Dictionary(grouping: empleados) { empleado in
			empleado.department
		}
	}
	
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
	
	/// Actualiza la lista de empleados con el empleado modificado, si existe.
	/// - Parámetros:
	///   - empleado: El empleado con la información actualizada.
	/// - Comportamiento:
	///   Busca el empleado en la lista interna `empleados` por su `id`. Si lo encuentra, lo reemplaza por la versión actualizada.
	///   Esto permite que la vista refleje inmediatamente los cambios locales realizados sobre un empleado sin tener que
	///   volver a cargar todos los datos.
	func saveEmpleado(_ empleado: Empleado) {
		if let index = empleados.firstIndex(where: { $0.id == empleado.id }) {
			empleados[index] = empleado
		}
	}
	
	/// Actualiza un empleado en el repositorio remoto y luego sincroniza el estado local con la última versión.
	///
	/// - Parámetros:
	///   - empleado: El empleado con la información ya validada y editada, listo para ser enviado al repositorio.
	///
	/// - Comportamiento:
	///   1. Envía el empleado actualizado al repositorio utilizando `updateEmpleado(_:)`.
	///   2. Si la operación es exitosa, vuelve a solicitar la información actualizada del empleado al repositorio con `getEmpleado(id:)`.
	///   3. Si el repositorio devuelve el empleado actualizado, se llama a `saveEmpleado(_:)` para reflejar los cambios en la lista local.
	///   4. Si ocurre algún error durante la actualización o la obtención del empleado, se asigna el mensaje de error a `errorMsg` y se muestra una alerta (`showErrorAlert`).
	///
	/// - Observación:
	///   Está marcado con `@MainActor` para asegurar que las operaciones que afectan directamente al estado observable
	///   (como `empleados`, `errorMsg` y `showErrorAlert`) se ejecuten en el hilo principal, evitando Data Races.
	@MainActor
	func updateEmpleado(_ empleado: Empleado) async {
		do {
			try await repository.updateEmpleado(empleado)
			if let updatedEmpleado = try await repository.getEmpleado(id: empleado.id) {
				saveEmpleado(updatedEmpleado)
			}
		} catch {
			self.errorMsg = error.localizedDescription
			self.showErrorAlert.toggle()
		}
	}
	
}

