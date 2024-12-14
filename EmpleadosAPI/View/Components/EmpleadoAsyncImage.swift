//
//  EmpleadoAsyncImage.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 10/12/24.
//
import SwiftUI

/// Esta es la vista que muestra la imagen de un empleado utilizando `AsyncImage`.
///
/// - Funcionalidad:
///   Esta vista intenta cargar la imagen del empleado desde su URL (almacenada en `empleado.avatar`).
///   Muestra un `ProgressView` mientras la imagen se descarga. Si la imagen se carga correctamente,
///   se aplica el estilo personalizado del empleado, y si ocurre un error, se muestra un ícono
///   alternativo.
///
/// - Flujo:
///   1. `AsyncImage` solicita la imagen a la URL especificada en `empleado.avatar`.
///   2. Muestra `ProgressView` mientras se descarga.
///   3. Una vez completada, si existe la imagen, se muestra con el estilo definido en `employeeListImgStyle()`.
///   4. Si hay un error, se muestra un ícono por defecto (persona rellena).
///
/// - Ejemplo:
///   ```swift
///   EmpleadoAsyncImage(empleado: .empleadoPreview)
///   ```
struct EmpleadoAsyncImage: View {
	let empleado: Empleado
	var body: some View {
		 /*
		  El uso de AsyncImage conlleva un problema ahora en Swift 6
		  que es la llamada "Re-Entrada del Actor":
		  Cuando se solitica el mismo resultado de la misma tarea
		  más de una vez antes de que la primera vez se descargue
		  y eso puede provocar un error redundante que bloquea la app
		  o que nunca llegue a descargar la imagen
		  */
		AsyncImage(url: empleado.avatar){ image in
			if let image = image.image {
				image
					.employeeListImgStyle()
			} else if image.error != nil {
				Image(systemName: "person.fill")
					.employeeListImgStyle()
			} else {
				ProgressView()
			}
		}
	}
}

#Preview {
	EmpleadoAsyncImage(empleado: .empleadoPreview)
}
