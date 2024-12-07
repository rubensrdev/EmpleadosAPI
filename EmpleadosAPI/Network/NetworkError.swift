//
//  NetworkError.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 7/12/24.
//
import Foundation

/// Enumeración que define diferentes tipos de errores de red que pueden ocurrir durante la interacción con una API.
///
/// - Conformidad con `LocalizedError`:
///   Proporciona descripciones personalizadas de los errores en forma de cadenas legibles.
///
/// Casos definidos:
/// - `general(Error)`: Representa un error general que encapsula cualquier objeto de tipo `Error`.
/// - `status(Int)`: Indica un error basado en un código de estado HTTP no exitoso.
/// - `json(Error)`: Identifica un error ocurrido durante el proceso de codificación o decodificación de JSON.
/// - `dataNotValid`: Señala que los datos recibidos no son válidos.
/// - `nonHTTP`: Representa un error cuando la respuesta no corresponde a un protocolo HTTP.
///
/// Propiedad `errorDescription`:
/// - Proporciona una descripción legible del error asociado a cada caso, útil para mostrar mensajes informativos en la interfaz de usuario o para depuración.
enum NetworkError: LocalizedError {
    case general(Error)
    case status(Int)
    case json(Error)
    case dataNotValid
    case nonHTTP
    
    var errorDescription: String? {
        switch self {
        case .general(let error):
            "Error general: \(error)"
        case .status(let code):
            "Error de status: \(code)"
        case .json(let error):
            "Error de JSON: \(error)"
        case .dataNotValid:
            "Error, dato no válido"
        case .nonHTTP:
            "Error, no es una petición HTTP"
        }
        
    }
}
