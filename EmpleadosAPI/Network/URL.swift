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
extension URL {
    /// Endpoint que devuelve todo los empleados del API Empleados
    static let getEmpleados = api.appending(path: "getEmpleados")
}


