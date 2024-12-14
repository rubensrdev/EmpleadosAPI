//
//  TextFieldEdit.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 13/12/24.
//
import SwiftUI

/// Este componente reutilizable es para editar campos de texto con validación integrada.
///
/// - Propósito:
///   Este componente muestra un campo de texto con un título descriptivo (`label`) y validación
///   dinámica de datos. Si el usuario introduce valores inválidos, se muestra un mensaje de error.
///   Además, ofrece la opción de borrar rápidamente el texto con un botón de limpieza cuando el campo tiene el foco.
///
/// - Personalización:
///   - `label`: Descripción textual del campo, se muestra como título y en mensajes de error.
///   - `contentType`: Define el tipo de contenido del texto (por ejemplo, `.emailAddress`, `.givenName`),
///     lo que puede ayudar al sistema a ofrecer sugerencias o comportamientos específicos.
///   - `autocapitalizationType`: Controla la capitalización automática, útil para nombres propios u otros campos.
///   - `campo`: Variable enlazada al valor del campo. Se actualiza en tiempo real a medida que el usuario escribe.
///   - `validate`: Función de validación que recibe el texto actual y devuelve un mensaje de error si no es válido, o `nil` en caso contrario.
///
/// - Comportamiento:
///   1. Cuando el usuario edita el texto, se llama a la función `validate`.
///   2. Si hay un error, se muestra el mensaje debajo del campo, y el contorno pasa a ser rojo.
///   3. El botón de borrado (x) aparece al tener el foco y contener texto, permitiendo limpiar rápidamente el contenido.
///   4. Las animaciones ofrecen una transición suave al aparecer o desaparecer el mensaje de error.
///
/// - Ejemplo de uso:
///   ```swift
///   @State var nombre = ""
///   TextFieldEdit(
///       label: "first name",
///       contentType: .givenName,
///       autocapitalizationType: .words,
///       campo: $nombre
///   ) { valor in
///       valor.isEmpty ? "cannot be empty" : nil
///   }
///   ```
struct TextFieldEdit: View {
	let label: String
	let contentType: UITextContentType
	let autocapitalizationType: TextInputAutocapitalization
	@Binding var campo: String
	@State private var errorText = false
	@State private var errorMsg = ""
	@FocusState private var isFocused: Bool
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
						.padding(.trailing, isFocused ? 30 : 10)
						.textContentType(contentType)
						.textInputAutocapitalization(autocapitalizationType)
						.autocorrectionDisabled(true)
						.focused($isFocused)
					
					if isFocused && !campo.isEmpty {
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
