//
//  EmpleadoEditView.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 13/12/24.
//

import SwiftUI

/// Esta es la vista de edición de un empleado, que permite modificar tanto información personal como corporativa.
///
/// - Objetivo:
///   Presentar un formulario para editar los datos de un empleado, separando la información en secciones.
///   La vista utiliza el `EmpleadoEditViewModel` para trabajar con una copia editable del empleado,
///   así como el componente `TextFieldEdit` para campos con validación integrada.
///
/// - Secciones del formulario:
///   1. **Personal Information:**
///      - Nombre (`firstName`)
///      - Apellido (`lastName`)
///      - Dirección (`address`)
///      - Género (`gender`) - seleccionado mediante un `Picker` con estilo segmentado.
///
///   2. **Corporate Information:**
///      - Email (`email`) - utiliza validación de formato con `validateEmail`.
///      - Nombre de usuario (`username`) - utiliza validación genérica para campos vacíos.
///      - Departamento (`department`) - seleccionado mediante un `Picker` con estilo navegación.
///
/// - Uso de `TextFieldEdit`:
///   Cada campo utiliza el componente personalizado `TextFieldEdit` para mostrar el texto, la etiqueta, el fondo y la validación
///   automáticamente. Si el campo es inválido, se muestra un mensaje de error.
///
/// - Navegación:
///   Esta vista se puede presentar dentro de una `NavigationStack` para ofrecer una experiencia
///   consistente con las convenciones de SwiftUI.
///
/// - Ejemplo:
///   ```swift
///   NavigationStack {
///       EmpleadoEditView(empleadoEditVM: EmpleadoEditViewModel(empleado: .empleadoPreview))
///   }
///   ```
struct EmpleadoEditView: View {
	@Bindable var empleadoEditVM: EmpleadoEditViewModel
	var body: some View {
		ScrollView {
			Form {
				Section {
					TextFieldEdit(label: "first name", contentType: .givenName, autocapitalizationType: .words, campo: $empleadoEditVM.firstName, validate: empleadoEditVM.validateIsEmpty)
					TextFieldEdit(label: "last name", contentType: .name, autocapitalizationType: .words, campo: $empleadoEditVM.lastName, validate: empleadoEditVM.validateIsEmpty)
					TextFieldEdit(label: "adress", contentType: .fullStreetAddress, autocapitalizationType: .words, campo: $empleadoEditVM.address, validate: empleadoEditVM.validateIsEmpty)
					TextFieldEdit(label: "zip code", contentType: .fullStreetAddress, autocapitalizationType: .words, campo: $empleadoEditVM.zipCode, validate: empleadoEditVM.validateIsEmpty)
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
						.padding(.top)
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
						.padding(.top)
				}
			}
			.formStyle(.columns)
			.padding()
			.toolbar {
				ToolbarItem(placement: .confirmationAction) {
					Button {
						print("guardar")
					} label: {
						HStack {
							Text("Save")
							Image(systemName: "square.and.arrow.down")
						}
					}
					.buttonStyle(.plain)
					
				}
			}
		}
	}
}

#Preview {
	NavigationStack {
		EmpleadoEditView(empleadoEditVM: EmpleadoEditViewModel(empleado: .empleadoPreview))
	}
}
