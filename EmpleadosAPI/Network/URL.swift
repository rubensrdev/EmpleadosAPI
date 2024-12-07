//
//  URL.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 6/12/24.
//

import Foundation

// Las definiciones de URL's a las que vamos a acceder desde la aplicación

/// URL de producción del API de Empleados
let prod = URL(string: "https://acacademy-employees-api.herokuapp.com/api")!
/// URL de desarrollo del API de Empleados
let desa = URL(string: "http://localhost:8080/api")

#if DEBUG
let api = prod // lo dejo en prod porque no tengo el api en local 😭
#else
let api = prod
#endif

// Extensión para crear todas las URL's usar en la aplicación de manera estática
// Combina la extensión de URLQueryItem con las funciones de URL para construir URLs limpias y fácilmente configurables.
// Ejemplo de uso: URLSession.shared.data(from: .getEmpleados)
extension URL {
    /// Propiedad que devuelve una URL para buscar todos los empleados del API Empleados
    static let getEmpleados = api.appending(path: "getEmpleados")
    /// Función que devuelve una URL configurada para buscar un empleado con un parámetro id
    static func getEmplead(id: Int) -> URL {
        api.appending(path: "getEmpleado").appending(path: "\(id)")
    }
    /// Función que devuelve una URL configurada para buscar empleados con un parámetro de consulta search.
    static func searchEmpleados(_ search: String) -> URL {
        api.appending(path: "searchEmpleados").appending(queryItems: [.search(search)])
    }
}
// URLQueryItem es: Es una estructura que representa un par clave-valor que se usa en la parte de consulta de una URL.
// Por ejemplo, en https://api.example.com?search=empleados, search=empleados es un URLQueryItem
// donde name es search y value es empleados.
extension URLQueryItem {
    /// Método estático que extiende a URLQueryItem donde el nombre del parámetro siempre será "search"
    /// y al que solo habrá que pasarle el valor de búsqueda
    static func search(_ search: String) -> URLQueryItem {
        URLQueryItem(name: "search", value: search)
    }
}

