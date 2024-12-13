//
//  EmpleadoEditView.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 13/12/24.
//

import SwiftUI

struct EmpleadoEditView: View {
	@Bindable var empleadoEditVM: EmpleadoEditViewModel
	var body: some View {
		Form {
			TextFieldEdit(label: "First Name", campo: $empleadoEditVM.firstName)
		}
	}
}

#Preview {
	EmpleadoEditView(empleadoEditVM: EmpleadoEditViewModel(empleado: .empleadoPreview))
}
