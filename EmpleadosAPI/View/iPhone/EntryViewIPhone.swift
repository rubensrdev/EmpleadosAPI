//
//  ContentView.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 6/12/24.
//

import SwiftUI

struct EntryViewIPhone: View {
	@State var vm = EmpleadosViewModel()
    var body: some View {
		NavigationStack {
			/* Sin secciones
			 List(vm.empleados) { empleado in
				 EmpleadoRow(empleado: empleado)
			 }
			 .navigationTitle("Employees")
			 */
			// Con secciones por DPTO
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



