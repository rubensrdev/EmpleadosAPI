//
//  TextFieldEdit.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 13/12/24.
//
import SwiftUI

struct TextFieldEdit: View {
	let label: String
	let contentType: UITextContentType
	let autocapitalizationType: TextInputAutocapitalization
	@Binding var campo: String
	@State private var errorText = false
	@State private var errorMsg = ""
	let validate: (String) -> String?
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(label.capitalized)
				.font(.headline)
				.foregroundColor(errorText ? .red : .primary)
			
			ZStack {
				RoundedRectangle(cornerRadius: 10)
					.fill(Color(.systemGray6))
					.overlay(
						RoundedRectangle(cornerRadius: 10)
							.stroke(errorText ? .red : .gray, lineWidth: errorText ? 2 : 1)
					)
				
				HStack {
					TextField("Enter the \(label.lowercased())", text: $campo, axis: .vertical)
						.padding(.leading, 10)
						.padding(.trailing, campo.isEmpty ? 10 : 30) // Espacio para el botón "X"
						.textContentType(contentType)
						.textInputAutocapitalization(autocapitalizationType)
						.autocorrectionDisabled(true)
					
					
					if !campo.isEmpty {
						Button(action: {
							campo = ""
						}) {
							Image(systemName: "xmark.circle.fill")
								.foregroundColor(.gray)
						}
						.padding(.trailing, 10)
					}
				}
			}
			.frame(height: 44)
			
			if errorText {
				Text(errorMsg)
					.font(.caption)
					.foregroundColor(.red)
					.transition(.opacity.combined(with: .slide))
			}
		}
		.padding()
		.onChange(of: campo) {
			if let msg = validate(campo) {
				errorMsg = "\(label.capitalized) \(msg)"
			} else {
				errorMsg = ""
			}
		}
		.onChange(of: errorMsg) {
			errorText = !errorMsg.isEmpty
		}
		.animation(.easeInOut, value: errorText)
	}
}

#Preview {
	@Previewable @State var campo: String = "Homer"
	TextFieldEdit(label: "first name", contentType: .givenName, autocapitalizationType: .words, campo: $campo) { value in
		if value.isEmpty {
			"cannot be empty"
		} else {
			nil
		}
	}
}
