//
//  EntryViewIPad16.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 13/12/24.
//

import SwiftUI

/// Vista principal adaptada para iOS 16 y superior, que aprovecha `NavigationSplitView`
/// para ofrecer una experiencia optimizada en iPad.
///
/// - Inyección de Dependencias:
///   Obtiene el ViewModel `EmpleadosViewModel` desde el entorno (`@Environment`).
///   Gracias a `@Bindable`, la vista se actualiza automáticamente cuando cambian las propiedades del ViewModel.
///
/// - Funcionalidad:
///   Presenta una estructura de navegación dividida en tres columnas:
///   1. **Departamentos (Izquierda):** Lista de departamentos disponibles.
///   2. **Empleados (Centro):** Empleados del departamento seleccionado.
///   3. **Detalle (Derecha):** Al seleccionar un empleado, muestra una vista para editar su información.
///
/// - Flujo:
///   1. Al aparecer, `vm.getEmpleados()` carga los empleados desde el repositorio.
///   2. El usuario escoge un departamento, filtrando los empleados mostrados.
///   3. Eligiendo un empleado, se muestra su detalle en la tercera columna.
///
/// - Interfaz:
///   Usa `NavigationSplitView` (iOS 16+), permitiendo mayor flexibilidad que `NavigationView`.
///   Cada columna puede ajustarse en tamaño, optimizando la experiencia en pantallas grandes.
///
/// - Errores:
///   Si ocurre algún fallo al obtener los empleados, se muestra una alerta con el mensaje descriptivo.
///
struct EntryViewIPad16: View {
	@Environment(EmpleadosViewModel.self) private var vm
	@State private var selectedDepartment: Empleado.Departamento? = Empleado.Departamento.allCases.first
	@State private var selectedEmpleado: Empleado?
	@State private var visibility: NavigationSplitViewVisibility = .all
    var body: some View {
		@Bindable var vm = vm
		NavigationSplitView(columnVisibility: $visibility) {
			List(selection: $selectedDepartment) {
				ForEach(Empleado.Departamento.allCases) { dpto in
					Text(dpto.rawValue)
						.tag(dpto)
				}
			}
			.navigationTitle("Departments")
			.navigationSplitViewColumnWidth(275)
		} content: {
			if let selectedDepartment {
				List(selection: $selectedEmpleado) {
					ForEach(vm.empleadosDepartamento[selectedDepartment, default: []]) { empleado in
						EmpleadoRow(empleado: empleado)
							.tag(empleado)
					}
				}
				.navigationTitle(selectedDepartment.rawValue)
				.navigationBarTitleDisplayMode(.inline)
				.navigationSplitViewColumnWidth(400)
			}
		} detail: {
			if let selectedEmpleado {
				EmpleadoEditView(empleadoEditVM: EmpleadoEditViewModel(empleado: selectedEmpleado))
			} else {
				ContentUnavailableView("Employee not selected", systemImage: "person.crop.circle", description: Text("Select an employee from the department or select a department tapping on left upper corner"))
			}
		}
		.task {
			await vm.getEmpleados()
		}
		.alert("App Error", isPresented: $vm.showErrorAlert) {} message: {
			Text(vm.errorMsg)
		}

    }
}

#Preview {
    EntryViewIPad16()
		.environment(EmpleadosViewModel(repository: PreviewRepository()))
}
