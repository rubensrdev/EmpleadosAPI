//
//  EmpleadosAPITests.swift
//  EmpleadosAPITests
//
//  Created by Rubén Segura Romo on 17/12/24.
//

import Testing
@testable import EmpleadosAPI

/// Suite de pruebas para validar la función `validateIsEmpty(value:)`
/// del `EmpleadoEditViewModel`.
///
/// La suite utiliza un ViewModel preconfigurado con `Empleado.empleadoPreview`
/// como datos de prueba.
@Suite("EmpleadosEditViewModel Tests")
struct EmpleadosAPIEdiValidationtTests {
	
	/// Instancia del ViewModel que se utiliza en las pruebas.
	/// Inicializada con datos de ejemplo mediante `Empleado.empleadoPreview`.
	private let vm: EmpleadoEditViewModel
	
	init() {
		vm = EmpleadoEditViewModel(empleado: .empleadoPreview)
	}


	/// Prueba que `validateIsEmpty` devuelve el mensaje `"cannot be empty"`
	/// cuando el valor proporcionado está vacío.
	///
	/// - Given: Una cadena vacía como entrada.
	/// - When: Se llama a `validateIsEmpty` con la cadena vacía.
	/// - Then: El resultado debe ser el mensaje `"cannot be empty"`.
	@Test func validateIsEmptyWhenValueIsEmpty() {
		// Given
		let text = ""
		// When
		let result = vm.validateIsEmpty(value: text)
		// Then
		#expect(result == "cannot be empty")
	}
	
	/// Prueba que `validateIsEmpty` devuelve `nil` cuando el valor proporcionado
	/// no está vacío.
	///
	/// - Given: Una cadena con contenido válido como entrada.
	/// - When: Se llama a `validateIsEmpty` con la cadena no vacía.
	/// - Then: El resultado debe ser `nil`.
	@Test func validateIsEmptyWhenValueNotIsEmpty() {
		// Given
		let text = "user"
		// When
		let result = vm.validateIsEmpty(value: text)
		// Then
		#expect(result == nil)
	}
	
	/// Prueba la función `validateEmail` cuando se proporciona una dirección de correo válida.
	/// - Given: Una cadena de texto con un formato de correo válido, como "user@example.com".
	/// - When: Se llama a `validateEmail(text:)` con el correo válido.
	/// - Then: La función debería devolver `nil`, indicando que no hay errores de validación.
	@Test func validateEmailWhenValueIsValid() {
		let email = "user@example.com"
		let result = vm.validateEmail(text: email)
		#expect(result == nil)
	}
	
	/// Prueba la función `validateEmail` cuando se proporciona una dirección de correo inválida.
	/// - Given: Una cadena de texto con un formato de correo inválido, sin el símbolo "@".
	/// - When: Se llama a `validateEmail(text:)` con el correo inválido.
	/// - Then: La función debería devolver un mensaje de error: `"is not a valid email"`.
	@Test func validateEmailWhenValueIsInvalid() {
		let email = "userexample.com"
		let result = vm.validateEmail(text: email)
		#expect(result == "is not a valid email")
	}
	
	/// Prueba la función `validateUsername` cuando se proporciona un nombre de usuario válido.
	/// - Given: Una cadena de texto que cumple con las reglas del nombre de usuario, como "user23".
	/// - When: Se llama a `validateUsername(value:)` con un nombre de usuario válido.
	/// - Then: La función debería devolver `nil`, indicando que no hay errores de validación.
	@Test func validateUserNameWhenValueIsValid() {
		let username = "user23"
		let result = vm.validateUsername(value: username)
		#expect(result == nil)
	}
	
	/// Prueba la función `validateUsername` cuando el nombre de usuario supera los 16 caracteres.
	/// - Given: Una cadena de texto con una longitud mayor a 16 caracteres, como "useruseruseruseruseruseruser".
	/// - When: Se llama a `validateUsername(value:)` con un nombre de usuario demasiado largo.
	/// - Then: La función debería devolver un mensaje de error: `"must be between 6 and 16 characters long"`.
	@Test func validateUserNameWhenValueLenghtIsOver16() {
		let username = "useruseruseruseruseruseruser"
		let result = vm.validateUsername(value: username)
		#expect(result == "must be between 6 and 16 characters long")
	}
	
	/// Prueba la función `validateUsername` cuando el nombre de usuario tiene menos de 6 caracteres.
	/// - Given: Una cadena de texto con menos de 6 caracteres, como "user".
	/// - When: Se llama a `validateUsername(value:)` con un nombre de usuario demasiado corto.
	/// - Then: La función debería devolver un mensaje de error: `"must be between 6 and 16 characters long"`.
	@Test func validateUserNameWhenValueLenghtIsLess6() {
		let username = "user"
		let result = vm.validateUsername(value: username)
		#expect(result == "must be between 6 and 16 characters long")
	}
	
	/// Prueba la función `validateUsername` cuando el nombre de usuario contiene caracteres no válidos.
	/// - Given: Una cadena de texto con caracteres especiales no permitidos, como "user23***".
	/// - When: Se llama a `validateUsername(value:)` con un nombre de usuario que contiene caracteres inválidos.
	/// - Then: La función debería devolver un mensaje de error: `"can only contain letters and numbers"`.
	@Test func validateUserNameWhenValueContainsCharactersInvalids() {
		let username = "user23***"
		let result = vm.validateUsername(value: username)
		#expect(result == "can only contain letters and numbers")
	}
	
	/// Prueba que `updateEmpleado` retorna `nil` y acumula errores
	/// cuando los campos `firstName` y `lastName` están vacíos.
	@Test func updateEmpleadoWithEmptyFirstNameAndLastName() {
		vm.firstName = ""
		vm.lastName = ""
		let result = vm.updateEmpleado()
		#expect(result == nil)
		#expect(vm.errorMessage.contains("First name cannot be empty"))
		#expect(vm.errorMessage.contains("Last name cannot be empty"))
		#expect(vm.showAlert == true)
	}
	
	/// Prueba que `updateEmpleado` retorna `nil` y acumula errores
	/// cuando el email es inválido.
	@Test func updateEmpleadoWithInvalidEmail() {
		vm.email = "email.invalid.com"
		let result = vm.updateEmpleado()
		#expect(result == nil)
		#expect(vm.errorMessage.contains("Email is not a valid email"))
		#expect(vm.showAlert == true)
	}
	
	/// Prueba que `updateEmpleado` retorna `nil` y acumula errores
	/// cuando los campos `address` y `zipCode` están vacíos.
	@Test func updateEmpleadoWithEmptyAddressAndZipCode() {
		vm.address = ""
		vm.zipCode = ""
		let result = vm.updateEmpleado()
		#expect(result == nil)
		#expect(vm.errorMessage.contains("Address cannot be empty"))
		#expect(vm.errorMessage.contains("Zip code cannot be empty"))
		#expect(vm.showAlert == true)
	}
	
	/// Prueba que `updateEmpleado` actualiza correctamente el empleado
	/// cuando todos los campos son válidos.
	@Test func updateEmpleadoWithValidData() {
		vm.firstName = "Idril"
		vm.lastName = "The Dog"
		vm.email = "idril.the@dog.com"
		vm.username = "idrilthedog"
		vm.address = "Ruben house"
		vm.zipCode = "12345"
		
		let result = vm.updateEmpleado()
		
		#expect(result != nil)
		#expect(result?.firstName == "Idril")
		#expect(result?.lastName == "The Dog")
		#expect(result?.email == "idril.the@dog.com")
		#expect(vm.errorMessage.isEmpty == true)
		#expect(vm.showAlert == false)
	}
	
}
