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
///   Esta vista utiliza `NavigationStack`, introducido en iOS 16, que ofrece una experiencia de navegación
///   más clara y declarativa que `NavigationView`.
///
/// - Estado:
///   - `vm`: Instancia de `EmpleadosViewModel`, encargada de obtener y filtrar los empleados por departamento.
///   - Las propiedades `showErrorAlert` y `errorMsg` del ViewModel controlan la presentación de errores.
///
/// - Flujo:
///   1. Al cargarse, la vista solicita los empleados al ViewModel (`vm.getEmpleados()`).
///   2. Una vez cargados, agrupa automáticamente los empleados por departamento utilizando el computed property `empleadosDepartamento`.
///   3. Cada departamento se muestra como una `Section` en el `List`, con enlaces de navegación a cada empleado.
///   4. Al pulsar sobre un empleado, se navega con `NavigationDestination` hacia `EmpleadoEditView`.
///
/// - Errores:
///   Si ocurre un error durante la carga de empleados, se muestra una alerta con el mensaje correspondiente.
///
struct EntryViewIPhone: View {
	@State var vm = EmpleadosViewModel()
    var body: some View {
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
		.alert("App Error", isPresented: $vm.showErrorAlert) {} message: {
			Text(vm.errorMsg)
		}
    }
}

#Preview {
	EntryViewIPhone(vm: EmpleadosViewModel(repository: PreviewRepository()))
}



