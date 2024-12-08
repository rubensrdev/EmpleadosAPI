//
//  ContentView.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 6/12/24.
//

import SwiftUI

struct EntryView: View {
	@State private var vm = EmpleadosViewModel()
    var body: some View {
		NavigationStack {
			List(vm.empleados) { empleado in
				Text(empleado.firstName)
			}
			.navigationTitle("Empleados")
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
    EntryView()
}
