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
	
	private let vm = EmpleadoEditViewModel(empleado: .empleadoPreview)

	/// La función `validateIsEmpty` se encarga de verificar si una cadena
	/// está vacía o no:
	/// - Resultado esperado:  `"cannot be empty"` porque la cadena text no tiene valor
	@Test func validateIsEmptyWhenValueIsEmpty() {
		// Given
		let text = ""
		// When
		let result = vm.validateIsEmpty(value: text)
		// Then
		#expect(result == "cannot be empty")
	}

	/// La función `validateIsEmpty` se encarga de verificar si una cadena
	/// está vacía o no:
	/// - Resultado esperado: `nil` porque la cadena text tiene valor
	@Test func validateIsEmptyWhenValueNotIsEmpty() {
		// Given
		let vm = EmpleadoEditViewModel(empleado: .empleadoPreview)
		let text = "user"
		// When
		let result = vm.validateIsEmpty(value: text)
		// Then
		#expect(result == nil)
	}
	
}
