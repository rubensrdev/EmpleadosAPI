//
//  TextFieldEdit.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 13/12/24.
//
import SwiftUI

struct TextFieldEdit: View {
	
	let label: String
	@Binding var campo: String
	@State private var errorText = false
	@State private var errorMsg = ""
	
	var body: some View {
		VStack(alignment: .leading) {
			
			Text(label.capitalized)
				.font(.headline)
				.foregroundStyle(errorText ? .red : .primary)
			TextField("Enter the \(label.lowercased())", text: $campo, axis: .vertical)
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
		.onChange(of: campo) {
			if campo.isEmpty {
				errorText = true
				errorMsg = "\(label) cannot be empty"
			} else {
				errorText = false
			}
		}
	}
}

#Preview {
	@Previewable @State var campo: String = ""
	TextFieldEdit(label: "First name", campo: $campo )
}
