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

