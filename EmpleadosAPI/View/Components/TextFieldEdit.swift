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
	
	var body: some View {
		VStack(alignment: .leading) {
			
			Text(label.capitalized)
				.font(.headline)
				.foregroundStyle(errorText ? .red : .primary)
			TextField("Enter the \(label.lowercased())", text: $campo, axis: .vertical)
				.lineLimit(2)
				.textContentType(contentType)
				.textInputAutocapitalization(autocapitalizationType)
				.autocorrectionDisabled(true)
		}
		.padding(5)
		.overlay {
			RoundedRectangle(cornerRadius: 10)
				.stroke(lineWidth: 2)
				.fill(.red)
				.opacity(errorText ? 1 : 0)
		}
		.overlay(alignment: .bottomLeading) {
			Text(errorMsg)
				.font(.caption2)
				.foregroundStyle(.red)
				.opacity(errorText ? 1 : 0)
				.offset(y: 13)
				.padding(.leading, 10)
		}
		.onChange(of: campo) {
			if campo.isEmpty {
				errorText = true
				errorMsg = "\(label) cannot be empty"
			} else {
				errorText = false
			}
		}
		.animation(.default, value: errorText)
	}
}

#Preview {
	@Previewable @State var campo: String = "Homer"
	TextFieldEdit(label: "First name", contentType: .givenName, autocapitalizationType: .words, campo: $campo )
}
