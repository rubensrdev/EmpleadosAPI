//
//  RemoteRepository.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 8/12/24.
//

import Foundation

/// Estructura que implementa las interacciones de red con el repositorio remoto.
/// - Propósito: Centralizar las solicitudes relacionadas con empleados desde una API remota.
/// - Implementa `NetworkInteractor` para reutilizar métodos genéricos de red.
/// - Implementa `RepositoryProtocol` para reutilizar métodos genéricos de repositorio.
struct RemoteRepository: NetworkInteractor, RepositoryProtocol {
	
	/// Recupera una lista de `Empleado` desde un recurso remoto
	/// - Retorno:
	///   - Una lista de `Empleado`
	/// - Errores:
	///   - Lanza `NetworkError` si ocurre un error de red, JSON o si el código de estado HTTP no es exitoso.
	func getEmpleados() async throws -> Empleados {
		try await executeRequest(request: .get(.getEmpleados), type: [EmpleadoDTO].self).compactMap(\.toEmpleado)
	}

	/// Recupera un `Empleado` desde un recurso remoto
	/// - Retorno:
	///   - Un `Empleado`
	/// - Errores:
	///   - Lanza `NetworkError` si ocurre un error de red, JSON o si el código de estado HTTP no es exitoso.
	func getEmpleado(id empleadoId: Int) async throws -> Empleado? {
		try await executeRequest(request: .get(.getEmplead(id: empleadoId)), type: EmpleadoDTO.self).toEmpleado
	}
	
	/// Actualiza la información de un empleado en la API remota.
	/// - Parámetros:
	///   - empleado: El empleado con la información actualizada a enviar al servidor.
	/// - Errores:
	///   - `NetworkError.status` si el código de estado no es el esperado.
	///   - `NetworkError.json` si hay un problema en la codificación o decodificación de datos.
	///   - `NetworkError.general` si ocurre algún otro error de red.
	func updateEmpleado(_ empleado: Empleado) async throws {
		try await validateStatus(request: .post(url: .empleado, body: empleado.update, method: .put))
	}
}
