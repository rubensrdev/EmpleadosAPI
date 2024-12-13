//
//  EntryViewIPad.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 13/12/24.
//

import SwiftUI

struct EntryViewIPad: View {
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
    EntryViewIPad(vm: EmpleadosViewModel(repository: PreviewRepository()))
}
