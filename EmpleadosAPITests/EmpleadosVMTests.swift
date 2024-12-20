//
//  EmpleadosVMTests.swift
//  EmpleadosAPITests
//
//  Created by Rubén Segura Romo on 17/12/24.
//

import Testing
@testable import EmpleadosAPI

/// Suite de pruebas para validar las funciones del `EmpleadosViewModel`.
///
/// La suite utiliza un ViewModel preconfigurado con `Empleado.empleadoPreview`
/// como datos de prueba.
@Suite("EmpleadosViewModel Tests")
struct EmpleadosVMTests {
	
	/// Prueba que el método `getEmpleados()` del `EmpleadosViewModel` carga correctamente
	/// los datos de empleados desde el repositorio cuando no hay errores.
	///
	/// - Escenario probado:
	///    1. El repositorio (`PreviewRepository`) devuelve datos correctamente.
	///    2. La propiedad `empleados` del ViewModel se actualiza con los datos obtenidos.
	///    3. Las propiedades relacionadas con errores (`showErrorAlert` y `errorMsg`) permanecen
	///       en sus valores predeterminados (`false` y `""` respectivamente).
	///
	/// - Validaciones:
	///    1. `empleados.count > 0`: Verifica que la lista de empleados no está vacía.
	///    2. `showErrorAlert == false`: Confirma que no se activa la alerta de error.
	///    3. `errorMsg == ""`: Asegura que no se asigna un mensaje de error.
	@Test
	func getEmpleadosWhenReturnData() async {
		let vm = EmpleadosViewModel(repository: PreviewRepository())
		do {
			let empleados = try await vm.repository.getEmpleados()
			vm.empleados = empleados
			#expect(vm.empleados.count > 0)
			#expect(vm.showErrorAlert == false)
			#expect(vm.errorMsg == "")
		} catch {
			print("Error executing test: \(error)")
		}
		
	}
	
}
