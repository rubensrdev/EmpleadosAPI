//
//  NetworkInteractor.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 7/12/24.
//

import Foundation

/// Este protocolo define un tipo como interactor de red
protocol NetworkInteractor {}

// Proporciona métodos genéricos para realizar peticiones GET y POST
extension NetworkInteractor {
	/// Este método genérico ejecuta una solicitud HTTP y decodifica la respuesta JSON en un tipo `Codable`.
	/// - Parámetros:
	///   - `request`: La solicitud HTTP a ejecutar (GET, POST, DELETE, PUT)
	///   - `type`: El tipo al que se desea decodificar la respuesta JSON.
	/// - Retorno:
	///   - Un objeto decodificado del tipo especificado (`JSON`).
	/// - Errores:
	///   - Lanza `NetworkError.status` si el código de estado HTTP no es 200.
	///   - Lanza `NetworkError.json` si la decodificación JSON falla.
	///   - Lanza `NetworkError.general` para errores generales durante la ejecución de la solicitud.
	func executeRequest<JSON>(request: URLRequest, type: JSON.Type) async throws(NetworkError) -> JSON where JSON: Codable {
		let (data, response) = try await URLSession.shared.getData(for: request)
		if response.statusCode == 200 {
			do {
				return try JSONDecoder().decode(JSON.self, from: data)
			} catch {
				throw .json(error)
			}
		} else {
			throw .status(response.statusCode)
		}
	}
	
	/// Este método genérico realiza una solicitud HTTTP de tipo POST y valida el código de estado devuelto
	/// - Parámetros:
	///   - `request`: La solicitud HTTP a ejecutar.
	///   - `status`: Código de estado esperado para una respuesta exitosa (por defecto, `200`).
	/// - Errores:
	///   - Lanza `NetworkError.status` si el código de estado HTTP no coincide con el esperado.
	func postJSON(request: URLRequest, status: Int = 200) async throws(NetworkError) {
		let (_, response) = try await URLSession.shared.getData(for: request)
		if response.statusCode != status {
			throw .status(response.statusCode)
		}
	}
	
}
