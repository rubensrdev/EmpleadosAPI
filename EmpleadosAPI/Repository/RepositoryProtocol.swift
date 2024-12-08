//
//  DataRepository.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 8/12/24.
//

/// Este protocolo define una interfaz común para todos los repositorios que gestionen datos relacionados con empleados
protocol RepositoryProtocol: Sendable {
	/// Función asíncrona que recupera una lista de todos los empleados.
	/// - Retorno:
	///   - Una colección de objetos `Empleado` (`Empleados`).
	/// - Errores:
	///   - Puede lanzar errores relacionados con la recuperación de datos.
	func getEmpleados() async throws -> Empleados
	
	/// Función asíncrona que recupera un empleado específico por su identificador.
	/// - Parámetros:
	///   - `empleadoId`: El identificador único del empleado a buscar.
	/// - Retorno:
	///   - Un objeto opcional `Empleado` si existe un empleado con el ID proporcionado, o `nil` si no se encuentra.
	/// - Errores:
	///   - Puede lanzar errores relacionados con la recuperación de datos.
	func getEmpleado(id empleadoId: Int) async throws -> Empleado?
}
