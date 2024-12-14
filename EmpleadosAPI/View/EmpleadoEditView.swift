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
			Section {
				TextFieldEdit(label: "first name", contentType: .givenName, autocapitalizationType: .words, campo: $empleadoEditVM.firstName, validate: empleadoEditVM.validateIsEmpty)
				TextFieldEdit(label: "last name", contentType: .name, autocapitalizationType: .words, campo: $empleadoEditVM.lastName, validate: empleadoEditVM.validateIsEmpty)
				TextFieldEdit(label: "adress", contentType: .fullStreetAddress, autocapitalizationType: .words, campo: $empleadoEditVM.address, validate: empleadoEditVM.validateIsEmpty)
				HStack {
					Text("Gender")
						.font(.headline)
					Picker(selection: $empleadoEditVM.gender) {
						ForEach(Empleado.Genero.allCases) { gender in
							Text(gender.rawValue)
								.tag(gender)
						}
					} label: {
						Text("Select the gender")
					}
					.pickerStyle(.segmented)
					.padding(.trailing)
				}
				
			} header: {
				Text("Personal Information")
					.font(.title)
					.bold()
			}
			
			Section {
				TextFieldEdit(label: "email", contentType: .emailAddress, autocapitalizationType: .never, campo: $empleadoEditVM.email, validate: empleadoEditVM.validateEmail)
					.keyboardType(.emailAddress)
				TextFieldEdit(label: "username", contentType: .username, autocapitalizationType: .words, campo: $empleadoEditVM.username, validate: empleadoEditVM.validateIsEmpty)
				
				Text("Department")
					.font(.headline)
				Picker(selection: $empleadoEditVM.department) {
					ForEach(Empleado.Departamento.allCases) { gender in
						Text(gender.rawValue)
							.tag(gender)
					}
				} label: {
					Text("Select the department")
				}
				.buttonStyle(.plain)
				.pickerStyle(.navigationLink)
				.padding(.trailing)
				
			} header: {
				Text("Corporate Information")
					.font(.title)
					.bold()
			}
		}
		.formStyle(.columns)
		.padding()
	}
}

#Preview {
	NavigationStack {
		EmpleadoEditView(empleadoEditVM: EmpleadoEditViewModel(empleado: .empleadoPreview))
	}
}
