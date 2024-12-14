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
		VStack(alignment: .leading, spacing: 16) {
			Text("Edit Employee")
				.font(.largeTitle)
				.fontWeight(.bold)
				.padding(.horizontal)
			Form {
				TextFieldEdit(label: "first name", contentType: .givenName, autocapitalizationType: .words, campo: $empleadoEditVM.firstName, validate: empleadoEditVM.validateIsEmpty)
				TextFieldEdit(label: "last name", contentType: .name, autocapitalizationType: .words, campo: $empleadoEditVM.lastName, validate: empleadoEditVM.validateIsEmpty)
				TextFieldEdit(label: "email", contentType: .emailAddress, autocapitalizationType: .never, campo: $empleadoEditVM.email, validate: empleadoEditVM.validateEmail)
					.keyboardType(.emailAddress)
			}
		}
		.padding(.top)
	}
}

#Preview {
	EmpleadoEditView(empleadoEditVM: EmpleadoEditViewModel(empleado: .empleadoPreview))
}
