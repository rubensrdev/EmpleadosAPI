//
//  EmpleadoCachedImageView.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 11/12/24.
//
import SwiftUI

struct EmpleadoCachedImageView: View {
	@State var cachedImage = CachedImageViewModel()
	let url: URL?
	var body: some View {
		VStack {
			if let image = cachedImage.cachedImage {
				Image(uiImage: image)
					.employeeListImgStyle()
			} else {
				Image(systemName: "person.fill")
					.employeeListImgStyle()
			}
		}
		.onAppear {
			if let url = url {
				cachedImage.getImage(url: url)
			}
		}
	}
}

#Preview {
	EmpleadoCachedImageView(url: Empleado.empleadoPreview.avatar)
}
