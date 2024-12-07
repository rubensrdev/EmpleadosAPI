//
//  File.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 7/12/24.
//
import Foundation

// Esta extensión añade dos métodos asíncronos a URLSession que simplifican la interación con API REST, gestionando
// respuestas y errores de red de forma centralizada y usando el enum de NetworkError para manejar los casos
// más específicos
extension URLSession {
    /// Realiza una solicitud GET a una URL y devuelve los datos (Data) junto con la respuesta HTTP (HTTPURLResponse)
    func getData(from url: URL) async throws(NetworkError) -> (data: Data, response: HTTPURLResponse) {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.nonHTTP
            }
            return (data, response)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw .general(error)
        }
    }
    
	/// Realiza una solicitud HTTP (de cualquier tipo, como POST, GET, etc) usando un URLRequest y devuelve los datos (Data) y la respuesta HTTP (HTTPURLResponse)
    func getData(from request: URLRequest) async throws(NetworkError) -> (data: Data, response: HTTPURLResponse) {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.nonHTTP
            }
            return (data, response)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw .general(error)
        }
    }
}
