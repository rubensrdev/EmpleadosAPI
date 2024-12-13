//
//  EntryViewIPad.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 13/12/24.
//

import SwiftUI

/// Vista principal para iPad que presenta un listado de departamentos y empleados.
///
/// - Compatibilidad:
///   Utiliza `NavigationView` para mantener compatibilidad retroactiva con iOS 15,
///   proporcionando una interfaz adaptada al iPad con navegación dividida entre departamentos y empleados.
///
/// - Funcionamiento:
///   La vista muestra una lista de departamentos en la columna de la izquierda y, al seleccionar uno,
///   despliega la lista de empleados correspondientes en la columna central. El usuario puede entonces
///   navegar hacia la vista de edición de un empleado en la columna derecha.
///
/// - Estado interno:
///   - `vm`: Un `EmpleadosViewModel` que contiene la lógica de negocio para obtener y gestionar los empleados.
///   - `selectedDepartment`: El departamento actualmente seleccionado, utilizado para filtrar la lista de empleados.
///
/// - Flujo:
///   1. Al aparecer la vista, se dispara la tarea `vm.getEmpleados()` para cargar los empleados desde el repositorio.
///   2. La lista de departamentos se muestra en la columna izquierda. Al seleccionar uno, se filtra `vm.empleadosDepartamento`
///      para mostrar solo los empleados de ese departamento.
///   3. Cada empleado se muestra en una `NavigationLink` que lleva a una vista de edición (`EmpleadoEditView`).
///   4. Si ningún empleado está seleccionado, se muestra una `ContentUnavailableView` con un mensaje de ayuda.
///
/// - Errores:
///   Si se produce un error al obtener los empleados, se muestra una alerta con el mensaje correspondiente.
///
struct EntryViewIPad: View {
	@State var vm = EmpleadosViewModel()
	@State private var selectedDepartment: Empleado.Departamento? = Empleado.Departamento.allCases.first
	var body: some View {
		NavigationView {
			List(selection: $selectedDepartment) {
				ForEach(Empleado.Departamento.allCases) { dpto in
					Text(dpto.rawValue)
						.tag(dpto)
				}
			}
			.navigationTitle("Departments")
			
			if let selectedDepartment {
				List {
					ForEach(vm.empleadosDepartamento[selectedDepartment, default: []]) { empleado in
						NavigationLink {
							EmpleadoEditView(empleadoEditVM: EmpleadoEditViewModel(empleado: empleado))
						} label: {
							EmpleadoRow(empleado: empleado)
						}
					}
				}
				.navigationTitle(selectedDepartment.rawValue)
			}
			
			ContentUnavailableView("Employee not selected", systemImage: "person.crop.circle", description: Text("Select an employee from the department or select a department tapping on left upper corner"))
			
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
    EntryViewIPad(vm: EmpleadosViewModel(repository: PreviewRepository()))
}
