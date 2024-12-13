//
//  EmpleadoEditViewModel.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 13/12/24.
//

import Foundation

@Observable
final class EmpleadoEditViewModel {
	let empleado: Empleado
	
	var firstName: String
	var lastName: String
	var email: String
	var username: String
	var address: String
	var department: Empleado.Departamento
	var gender: Empleado.Genero
	
	init (empleado: Empleado) {
		self.empleado = empleado
		
		firstName = empleado.firstName
		lastName = empleado.lastName
		email = empleado.email
		username = empleado.username
		address = empleado.address
		department = empleado.department
		gender = empleado.gender
	}
	
	func validateIsEmpty(value: String) -> String? {
		if value.isEmpty {
			"cannot be empty"
		} else {
			nil
		}
	}
	
	func validateEmail(text: String) -> String? {
		let emailRegex = #"""
		(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|
		"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|
		\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")
		@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[
		(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}
		(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:
		(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|
		\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])
		"""#

		do {
			let regex = try Regex(emailRegex)
			return try regex.wholeMatch(in: text) != nil ? nil : "is not a valid email"
		} catch {
			return "is not a valid email"
		}
	}
}
