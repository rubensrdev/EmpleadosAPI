//
//  EmpleadoEditView.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 13/12/24.
//

import SwiftUI

struct EmpleadoEditView: View {
	@State var empleadoEditVM: EmpleadoEditViewModel
	var body: some View {
		VStack {
			Text(empleadoEditVM.empleado.fullName)
		}
	}
}

#Preview {
	EmpleadoEditView(empleadoEditVM: EmpleadoEditViewModel(empleado: .empleadoPreview))
}
