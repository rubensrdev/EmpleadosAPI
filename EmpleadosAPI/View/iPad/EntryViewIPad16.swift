//
//  EntryViewIPad16.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 13/12/24.
//

import SwiftUI

/// Vista principal adaptada para iOS 16 y superior, que aprovecha `NavigationSplitView` para
/// ofrecer una experiencia optimizada en iPad.
///
/// - Funcionalidad:
///   Presenta una estructura de navegación dividida en tres columnas:
///   1. **Columna de Departamentos:** Muestra una lista de departamentos disponibles.
///   2. **Columna de Empleados:** Cuando se selecciona un departamento, se despliega su lista de empleados.
///   3. **Columna Detalle:** Al seleccionar un empleado, muestra una vista de edición detallada.
///
/// - Estado:
///   - `vm`: Instancia de `EmpleadosViewModel`, el cual se encarga de obtener y manejar datos de empleados.
///   - `selectedDepartment`: El departamento actualmente seleccionado en la primera columna.
///   - `selectedEmpleado`: El empleado actualmente seleccionado en la segunda columna.
///
/// - Flujo:
///   1. Al aparecer la vista, se ejecuta `vm.getEmpleados()` para cargar los empleados.
///   2. El usuario selecciona un departamento en la primera columna, filtrando así los empleados mostrados en la segunda.
///   3. Al elegir un empleado en la segunda columna, se presenta su información en la tercera columna (detalle).
///
/// - Interfaz:
///   Usa `NavigationSplitView`, disponible en iOS 16 y versiones superiores, permitiendo una experiencia más flexible
///   que `NavigationView`. Cada columna puede ajustarse a anchos fijos, brindando una navegación más ergonómica en iPad.
///
/// - Errores:
///   Si ocurre algún fallo al obtener los empleados, se muestra una alerta informando del problema.
struct EntryViewIPad16: View {
	@State var vm = EmpleadosViewModel()
	@State private var selectedDepartment: Empleado.Departamento? = Empleado.Departamento.allCases.first
	@State private var selectedEmpleado: Empleado?
	@State private var visibility: NavigationSplitViewVisibility = .all
    var body: some View {
		NavigationSplitView(columnVisibility: $visibility) {
			List(selection: $selectedDepartment) {
				ForEach(Empleado.Departamento.allCases) { dpto in
					Text(dpto.rawValue)
						.tag(dpto)
				}
			}
			.navigationTitle("Departments")
			.navigationSplitViewColumnWidth(250)
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
}
