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
			TextFieldEdit(label: "first name", contentType: .givenName, autocapitalizationType: .words, campo: $empleadoEditVM.firstName, validate: empleadoEditVM.validateIsEmpty)
			TextFieldEdit(label: "last name", contentType: .name, autocapitalizationType: .words, campo: $empleadoEditVM.lastName, validate: empleadoEditVM.validateIsEmpty)
			TextFieldEdit(label: "email", contentType: .emailAddress, autocapitalizationType: .never, campo: $empleadoEditVM.email, validate: empleadoEditVM.validateEmail)
				.keyboardType(.emailAddress)
		}
	}
}

#Preview {
	EmpleadoEditView(empleadoEditVM: EmpleadoEditViewModel(empleado: .empleadoPreview))
}
