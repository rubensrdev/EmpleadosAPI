//
//  EmpleadoAsyncImage.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 10/12/24.
//
import SwiftUI

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
