//
//  EmpleadoEditView.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 13/12/24.
//

import SwiftUI

struct EmpleadoEditView: View {
	@Bindable var empleadoEditVM: EmpleadoEditViewModel
	@State private var errorText = false
	@State private var errorMsg = ""
	var body: some View {
		Form {
			VStack(alignment: .leading) {
				Text("First Name")
					.font(.headline)
					.foregroundStyle(errorText ? .red : .primary)
				TextField("Enter the first name", text: $empleadoEditVM.firstName, axis: .vertical)
					.lineLimit(2)
					.textContentType(.givenName)
					.textInputAutocapitalization(.words)
					.autocorrectionDisabled(true)
				Text(errorMsg)
					.font(.caption2)
					.foregroundStyle(.red)
					.opacity(errorText ? 1 : 0)
			}
			.padding(5)
			.overlay {
				RoundedRectangle(cornerRadius: 10)
					.stroke(lineWidth: 2)
					.fill(.red)
					.opacity(errorText ? 1 : 0)
			}
			.onChange(of: empleadoEditVM.firstName) {
				if empleadoEditVM.firstName.isEmpty {
					errorText = true
					errorMsg = "First name cannot be empty"
				} else {
					errorText = false
				}
			}
		}
	}
}

#Preview {
	EmpleadoEditView(empleadoEditVM: EmpleadoEditViewModel(empleado: .empleadoPreview))
}
