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
			List(vm.empleados) { empleado in
				HStack {
					VStack(alignment: .leading) {
						Text(empleado.fullName)
							.font(.headline)
						Text(empleado.email)
							.font(.footnote)
							.foregroundStyle(.secondary)
						Text(empleado.username)
							.font(.caption)
							.foregroundStyle(.tertiary)
					}
					Spacer()
					EmpleadoAsyncImage(empleado: empleado)
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


