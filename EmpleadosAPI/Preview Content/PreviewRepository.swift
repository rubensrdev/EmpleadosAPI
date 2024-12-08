//
//  PreviewRepository.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 8/12/24.
//

import Foundation

/// Una estructura que funciona como repositorio de pruebas para datos de los empleados
/// obteniendolos de un fichero JSON local con datos simulados
struct PreviewRepository: NetworkInteractor, RepositoryProtocol {
	
	/// Recupera una lista de todos los empleados desde un archivo local de pruebas.
	/// - Retorno:
	///   - Una colección de objetos `Empleado` (`Empleados`).
	/// - Errores:
	///   - Lanza errores si ocurre un problema al cargar o decodificar el archivo JSON.
	func getEmpleados() async throws -> Empleados {
		try getJSON(url: Bundle.main.url(forResource: "empleadosPreview", withExtension: "json")!, type: [EmpleadoDTO].self).compactMap(\.toEmpleado)
	}

	/// Recupera un empleado específico por su identificador desde un archivo local de pruebas.
	/// - Parámetros:
	///   - `empleadoId`: El identificador único del empleado a buscar.
	/// - Retorno:
	///   - Un objeto opcional `Empleado` si se encuentra el empleado con el ID proporcionado, o `nil` si no existe.
	/// - Errores:
	///   - Lanza errores si ocurre un problema al cargar o decodificar el archivo JSON.
	func getEmpleado(id empleadoId: Int) async throws -> Empleado? {
		try getJSON(url: Bundle.main.url(forResource: "empleadosPreview", withExtension: "json")!, type: [EmpleadoDTO].self).compactMap(\.toEmpleado).first
	}
	
	/// Decodifica un archivo JSON local en un objeto del tipo especificado.
	/// - Parámetros:
	///   - `url`: La URL del archivo JSON local.
	///   - `type`: El tipo al que se desea decodificar el JSON.
	/// - Retorno:
	///   - Un objeto decodificado del tipo especificado (`JSON`).
	/// - Errores:
	///   - Lanza errores si no se puede cargar o decodificar el archivo JSON.
	func getJSON<JSON>(url: URL, type: JSON.Type) throws -> JSON where JSON: Decodable {
		let data = try Data(contentsOf: url)
		return try JSONDecoder().decode(type, from: data)
	}
}
