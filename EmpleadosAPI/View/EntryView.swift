//
//  ContentView.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 6/12/24.
//

import SwiftUI

struct EntryView: View {
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
							EmpleadoRow(empleado: empleado)
						}
					} header: {
						Text(dpto.rawValue)
					}
				}
			}
			.navigationTitle("Employees")
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
	EntryView(vm: EmpleadosViewModel(repository: PreviewRepository()))
}



