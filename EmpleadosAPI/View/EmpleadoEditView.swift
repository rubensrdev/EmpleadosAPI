//
//  EmpleadoEditView.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 13/12/24.
//

import SwiftUI

/// Vista de edición de un empleado que combina datos personales y corporativos con validación de campos.
///
/// - Objetivo:
///   Esta vista presenta un formulario dividido en secciones para editar la información de un empleado.
///   Utiliza `EmpleadoEditViewModel` para gestionar el estado editable y las validaciones, y `TextFieldEdit`
///   para ofrecer campos con validación integrada. Permite actualizar el empleado a través de `EmpleadosViewModel`
///   obtenido del entorno.
///
/// - Secciones del formulario:
///   1. **Personal Information**:
///      - `firstName`, `lastName`, `address`, `zipCode`
///      - `gender` seleccionable mediante `Picker` con estilo segmentado.
///
///   2. **Corporate Information**:
///      - `email` (validación de formato con `validateEmail`)
///      - `username` (validación de longitud y caracteres con `validateUsername`)
///      - `department` seleccionable mediante `Picker` con estilo navegación.
///
/// - Validaciones:
///   Cada campo se valida conforme el usuario edita. Si un campo no cumple las condiciones,
///   aparece un mensaje de error debajo del `TextField`. Si al pulsar "Save" existen errores,
///   se muestra una alerta con un mensaje global, evitando guardar los cambios.
///
/// - Guardado:
///   El botón "Save" en la barra de herramientas intenta crear un `Empleado` actualizado mediante `updateEmpleado()`.
///   Si la validación pasa, el ViewModel del entorno (`EmpleadosViewModel`) actualiza el empleado remotamente
///   llamando a `updateEmpleado(_:)`. Si la actualización es exitosa, la vista se cierra (`dismiss()`).
///
/// - Navegación:
///   Puede presentarse dentro de una `NavigationStack` para una experiencia de navegación coherente con SwiftUI.
///
/// - Ejemplo:
///   ```swift
///   NavigationStack {
///       EmpleadoEditView(empleadoEditVM: EmpleadoEditViewModel(empleado: .empleadoPreview))
///           .environment(EmpleadosViewModel(repository: PreviewRepository()))
///   }
///   ```
struct EmpleadoEditView: View {
	@Bindable var empleadoEditVM: EmpleadoEditViewModel
	@Environment(EmpleadosViewModel.self) private var vm
	@Environment(\.dismiss) var dismiss
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
					TextFieldEdit(label: "username", contentType: .username, autocapitalizationType: .words, campo: $empleadoEditVM.username, validate: empleadoEditVM.validateUsername)
					
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
						if let empleado = empleadoEditVM.updateEmpleado() {
							Task {
								await vm.updateEmpleado(empleado)
								dismiss()
							}
						}
					} label: {
						HStack {
							Text("Save")
							Image(systemName: "square.and.arrow.down")
						}
					}
					.buttonStyle(.plain)
					
				}
			}
			.alert(
				"Validation Error",
				isPresented: $empleadoEditVM.showAlert) {}
				message: { Text(empleadoEditVM.errorMessage)}
		}
	}
}

#Preview {
	NavigationStack {
		EmpleadoEditView(empleadoEditVM: EmpleadoEditViewModel(empleado: .empleadoPreview))
			.environment(EmpleadosViewModel(repository: PreviewRepository()))
	}
}
