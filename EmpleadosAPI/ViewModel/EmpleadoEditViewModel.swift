//
//  EmpleadoEditViewModel.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 13/12/24.
//

import Foundation

/// Este ViewModel es el encargado de gestionar la edición de información de un empleado.
///
/// - Características:
///   Este ViewModel encapsula los datos y la lógica de validación necesarios para editar la información
///   de un empleado sin modificar directamente la instancia original. Facilita la separación entre la
///   capa de datos y la interfaz de usuario, manteniendo las vistas más limpias.
///
/// - Uso de `@Observable`:
///   Permite que las vistas en SwiftUI se actualicen automáticamente al cambiar las propiedades,
///   sin necesidad de `@Published` o notificaciones manuales.
///
/// - Propiedades:
///   - `empleado`: El empleado original a editar.
///   - `firstName`, `lastName`, `email`, `username`, `address`, `department`, `gender`:
///     Propiedades que representan la información editable del empleado.
///     Inicializadas a partir del empleado original, y modificables por la vista.
///
/// - Validaciones:
///   Contiene métodos de validación simples para campos vacíos y emails con formato inválido.
///   Esto asegura una primera capa de validación de datos antes de guardar los cambios.
///
/// - Métodos:
///   - `validateIsEmpty(value:)`: Devuelve un mensaje de error si la cadena está vacía, o `nil` si es válida.
///   - `validateEmail(text:)`: Comprueba mediante una expresión regular si el texto es un email válido. Devuelve `nil` si es correcto, o un mensaje de error si no lo es.
@Observable
final class EmpleadoEditViewModel {
	let empleado: Empleado
	
	var firstName: String
	var lastName: String
	var email: String
	var username: String
	var address: String
	var zipCode: String
	var department: Empleado.Departamento
	var gender: Empleado.Genero
	
	init (empleado: Empleado) {
		self.empleado = empleado
		
		firstName = empleado.firstName
		lastName = empleado.lastName
		email = empleado.email
		username = empleado.username
		address = empleado.address
		zipCode = empleado.zipcode
		department = empleado.department
		gender = empleado.gender
	}
	
	/// Valida que un valor no esté vacío.
	/// - Parámetros:
	///   - value: La cadena a validar.
	/// - Retorno:
	///   - Una cadena con el mensaje de error si está vacío, `nil` si es válido.
	func validateIsEmpty(value: String) -> String? {
		if value.isEmpty {
			"cannot be empty"
		} else {
			nil
		}
	}
	
	/// Valida que el texto tenga un formato de email válido.
	/// - Parámetros:
	///   - text: La cadena a validar como email.
	/// - Retorno:
	///   - `nil` si el texto es un email válido, de lo contrario un mensaje de error.
 	func validateEmail(text: String) -> String? {
		let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
		return text.range(of: emailRegex, options: .regularExpression) != nil ? nil : "is not a valid email"
	}
}
