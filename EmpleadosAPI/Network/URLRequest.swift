//
//  URLRequest.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 7/12/24.
//

import Foundation

/// Definición de una lista de métodos HTTP comunes que se utilizan para interactuar con API REST
enum HTTPMethod: String {
	/// Para enviar datos al servidor
    case post = "POST"
	/// Para solicitar datos al servidor
    case get = "GET"
	/// Para eliminar datos del servidor
	case delete = "DELETE"
	/// Para actualizar datos existentes
	case put = "PUT"
}

// Parametrización de las Request mediante la extensión de URLRequest
extension URLRequest {
	/// Método estático que genera  y configura una solicitud de tipo HTTP GET, con unos ajustes predeterminados necesarios para interacturar con una API REST
	static func get(_ url: URL) -> URLRequest {
		var request = URLRequest(url: url)
		request.timeoutInterval = 60
		request.httpMethod = HTTPMethod.get.rawValue
		request.setValue("applicartion/json", forHTTPHeaderField: "Accept")
		return request
	}
	
	/// Método estático que genera y configura un solicitud HTTP POST, con un cuerpo codificado como JSON y con unos ajustes predeterminados
	/// para interacturas con una API REST
	static func post<JSON>(url: URL, body: JSON, method: HTTPMethod = .post) -> URLRequest where JSON: Codable {
		var request = URLRequest(url: url)
		request.timeoutInterval = 60
		request.httpMethod = HTTPMethod.post.rawValue
		request.setValue("applicartion/json", forHTTPHeaderField: "Accept")
		request.setValue("applicartion/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
		request.httpBody = try? JSONEncoder().encode(body)
		return request
	}
}

