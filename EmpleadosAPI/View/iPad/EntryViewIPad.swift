//
//  EntryViewIPad.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 13/12/24.
//

import SwiftUI

/// Vista principal para iPad que presenta un listado de departamentos y empleados,
/// utilizando `NavigationView` para compatibilidad con iOS 15.
///
/// - Inyección de Dependencias:
///   Obtiene el ViewModel `EmpleadosViewModel` desde el entorno (`@Environment`),
///   lo que facilita la sustitución del repositorio para pruebas o previews.
///   El ViewModel se marca con `@Bindable` para que la vista reaccione automáticamente
///   a cambios en sus propiedades.
///
/// - Funcionamiento:
///   1. Columna Izquierda (Departamentos): Muestra la lista de departamentos.
///      Al seleccionar uno, se filtran los empleados para mostrar solo los de ese departamento.
///   2. Columna Central (Empleados): Presenta la lista de empleados del departamento seleccionado.
///      Cada empleado ofrece un `NavigationLink` para acceder a su vista de edición.
///   3. Columna Derecha (Detalle): Si se selecciona un empleado, se muestra su vista de edición.
///      Si no hay ningún empleado seleccionado, se muestra una vista indicando que no se ha seleccionado ninguno.
///
/// - Flujo de Datos:
///   - Al aparecer la vista, se llama a `vm.getEmpleados()` para cargar los datos desde el repositorio.
///   - Al seleccionar un departamento, se utiliza `vm.empleadosDepartamento` para actualizar la lista de empleados.
///   - Al elegir un empleado, se abre `EmpleadoEditView` para modificar su información.
///
/// - Errores:
///   Si ocurre un error durante la obtención de los empleados, se muestra una alerta con el mensaje descriptivo.
///
/// - Ejemplo de uso en `Preview`:
///   ```swift
///   EntryViewIPad()
///       .environment(EmpleadosViewModel(repository: PreviewRepository()))
///   ```
struct EntryViewIPad: View {
	@Environment(EmpleadosViewModel.self) private var vm
	@State private var selectedDepartment: Empleado.Departamento? = Empleado.Departamento.allCases.first
	var body: some View {
		@Bindable var vm = vm
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
		.refreshable {
			await vm.getEmpleados()
		}
		.alert("App Error", isPresented: $vm.showErrorAlert) {} message: {
			Text(vm.errorMsg)
		}
	}
}

#Preview {
    EntryViewIPad()
		.environment(EmpleadosViewModel(repository: PreviewRepository()))
}
