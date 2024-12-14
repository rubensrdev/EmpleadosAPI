//
//  EmpleadoRow.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 10/12/24.
//
import SwiftUI

/// Fila que muestra la información básica de un empleado dentro de una lista.
///
/// - Objetivo:
///   Presentar una vista compacta con los datos más relevantes de un empleado. Incluye nombre completo,
///   correo electrónico y nombre de usuario, además de una imagen representativa del empleado.
///
/// - Diseño:
///   La vista utiliza un `HStack` para alinear el texto a la izquierda y la imagen a la derecha,
///   manteniendo un espaciado constante.
///
/// - Imagen:
///   En lugar de `EmpleadoAsyncImage`, se emplea `EmpleadoCachedImageView` para cargar la imagen.
///   Esto reduce problemas de concurrencia y evita descargar la misma imagen varias veces,
///   ofreciendo una experiencia más eficiente.
///
/// - Ejemplo:
///   ```swift
///   List {
///       EmpleadoRow(empleado: empleado)
///   }
///   ```
struct EmpleadoRow: View {
	let empleado: Empleado
	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text(empleado.fullName)
					.font(.headline)
				Text(empleado.email)
					.font(.footnote)
					.foregroundStyle(.secondary)
				Text(empleado.username)
					.font(.caption)
					.foregroundStyle(.tertiary)
			}
			Spacer()
			// EmpleadoAsyncImage(empleado: empleado)
			EmpleadoCachedImageView(url: empleado.avatar)
		}
		.padding(.trailing, 10)
	}
}

#Preview {
	EmpleadoRow(empleado: .empleadoPreview)
}

