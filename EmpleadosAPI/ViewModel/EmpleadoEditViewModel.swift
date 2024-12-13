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
		let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
		return text.range(of: emailRegex, options: .regularExpression) != nil ? nil : "is not a valid email"
	}
}
