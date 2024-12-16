//
//  DataRepository.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 8/12/24.
//

// Se ha tenido que conformar a Sendable para evitar DataRace al instanciarlo
// en el VM. Esto es porque al ser protocol no lo conforma por defecto (las clases
// y estructuras si) y para cumplir con los requisitos de seguridad en concurrencia
// es necesario y así puede usarse en contextos concurrentes o actor-isolated
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
	
	/// Función asíncrona que actualiza la información de un empleado existente en la fuente de datos.
	/// - Parámetros:
	///   - `empleado`: El empleado con la información actualizada a persistir.
	/// - Errores:
	///   - Puede lanzar errores relacionados con la persistencia o la comunicación con el servidor.
	///     Por ejemplo, un fallo al conectar con la API, un error de validación o un problema de acceso a la base de datos.
	func updateEmpleado(_ empleado: Empleado) async throws
}
