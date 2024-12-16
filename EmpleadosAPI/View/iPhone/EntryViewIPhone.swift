//
//  ContentView.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 6/12/24.
//

import SwiftUI

/// Vista principal para iPhone que muestra una lista de departamentos y empleados en una jerarquía navegable.
///
/// - Funcionalidad:
///   Presenta todos los departamentos como secciones en una lista. Cada sección contiene la lista de empleados
///   pertenecientes a ese departamento. Al seleccionar un empleado, se navega a una vista de edición detallada.
///
/// - Arquitectura:
///   - Utiliza `NavigationStack`, disponible en iOS 16+, para una experiencia de navegación más clara y declarativa.
///   - El ViewModel (`EmpleadosViewModel`) se obtiene desde el entorno (`@Environment`), permitiendo así la
///     inyección de dependencias y facilitando el uso de diferentes repositorios en entornos de pruebas o previews.
///
/// - Estado:
///   - `vm`: Se recupera del entorno y se marca con `@Bindable` para actualizar la UI automáticamente
///     cuando cambian las propiedades del ViewModel, como `showErrorAlert` y `errorMsg`.
///
/// - Flujo:
///   1. Al cargarse la vista, se solicita la lista de empleados usando `vm.getEmpleados()`.
///   2. Los empleados se agrupan automáticamente por departamento mediante la propiedad calculada `empleadosDepartamento`.
///   3. Cada departamento se muestra como una `Section` en el `List`, y cada empleado como una fila con `NavigationLink`.
///   4. Al seleccionar un empleado, la navegación se dirige a `EmpleadoEditView`, donde se puede editar la información del empleado.
///
/// - Errores:
///   Si ocurre un error al obtener los empleados, se muestra una alerta con el mensaje correspondiente.
///
/// - Ejemplo de uso en `Preview`:
///   ```swift
///   EntryViewIPhone()
///       .environment(EmpleadosViewModel(repository: PreviewRepository()))
///   ```
struct EntryViewIPhone: View {
	@Environment(EmpleadosViewModel.self) private var vm
    
	var body: some View {
		@Bindable var vm = vm
		NavigationStack {
			List {
				ForEach(Empleado.Departamento.allCases) { dpto in
					Section {
						ForEach(vm.empleadosDepartamento[dpto, default: []]) { empleado in
							NavigationLink(value: empleado) {
								EmpleadoRow(empleado: empleado)
							}
						}
					} header: {
						Text(dpto.rawValue)
					}
				}
			}
			.navigationTitle("Employees")
			.navigationDestination(for: Empleado.self) { empleado in
				EmpleadoEditView(empleadoEditVM: EmpleadoEditViewModel(empleado: empleado))
			}
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
	EntryViewIPhone()
		.environment(EmpleadosViewModel(repository: PreviewRepository()))
}



