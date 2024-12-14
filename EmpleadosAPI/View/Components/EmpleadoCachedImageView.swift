//
//  EmpleadoCachedImageView.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 11/12/24.
//
import SwiftUI

/// Esta es la vista que muestra la imagen de un empleado utilizando un ViewModel de caché para evitar descargas innecesarias.
///
/// - Objetivo:
///   Esta vista utiliza un `CachedImageViewModel` para cargar imágenes de forma más controlada
///   y eficiente, evitando el problema de re-entrada de actor que puede ocurrir con `AsyncImage`.
///
/// - Funcionamiento:
///   1. Al aparecer la vista, se verifica si `url` es válida.
///   2. Si existe una URL, el `CachedImageViewModel` intenta obtener la imagen:
///      - Primero se comprueba la caché local.
///      - Si la imagen no está en caché, se descarga y guarda para usos futuros.
///   3. Si la imagen está disponible (`cachedImage.cachedImage`), se muestra con un estilo personalizado (`employeeListImgStyle()`).
///   4. Si no se encuentra la imagen, se presenta un ícono por defecto (`person.fill`).
///
/// - Ventajas:
///   - Evita descargas repetidas de la misma imagen.
///   - Ofrece una experiencia más fluida y rápida al reutilizar imágenes ya cargadas.
///
/// - Ejemplo:
///   ```swift
///   EmpleadoCachedImageView(url: Empleado.empleadoPreview.avatar)
///   ```
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
