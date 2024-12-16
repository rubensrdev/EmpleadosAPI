//
//  ModelAPI.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 16/12/24.
//

import Foundation

/// Representación del modelo Empleado en el API
struct EmpleadosUpdate: Codable {
	var id: Int
	var username: String?
	var firstName: String?
	var lastName: String?
	var email: String?
	var address: String?
	var avatar: String?
	var zipcode: String?
	var department: String?
	var gender: String?
}

// Extensión que facilita la conversión de un `Empleado` a un objeto `EmpleadosUpdate`.
extension Empleado {
	/// Esta propiedad calculada `update` crea y devuelve una instancia de `EmpleadosUpdate` utilizando las propiedades existentes del empleado.
	var update: EmpleadosUpdate {
		EmpleadosUpdate(id: id, username: username, firstName: firstName, lastName: lastName, email: email, address: address, avatar: avatar?.absoluteString, zipcode: zipcode, department: department.rawValue, gender: gender.rawValue)
	}
}
