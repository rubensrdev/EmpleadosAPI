//
//  CachedImageViewModel.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 10/12/24.
//

import SwiftUI

/// Este View Model se encarga de obtener las imagenes almacenadas en caché utilizando el `ImageDownloader`
/// previamente definido y evitando descargas innecesarias.
/// - Usa `@Observable` para notificar automáticamente a la vista cuando `cachedImage` cambie,
///   permitiendo que la UI se actualice de forma reactiva.
/// - Está marcado con `@MainActor`, lo que asegura que las actualizaciones de la UI
///   y las propiedades observables se realicen en el hilo principal, evitando Data Race
@Observable @MainActor
final class CachedImageViewModel {
	/// La imagen que tenemos actualmente en caché y lista para mostrar
	/// Cuando se le asigna otro valor la vista se actualiza automáticamente gracias a `@Observable`
	var cachedImage: UIImage?
	
	/// Obtiene una imagen a partir de una URL.
	/// Primero intenta cargarla desde la caché local, y si no existe, inicia una tarea para descargarla.
	/// - Parámetros:
	/// - url: La URL de la imagen a obtener.
	func getImage(url: URL) {
		let urlCache = URL.cachesDirectory.appending(path: url.lastPathComponent)
		if FileManager.default.fileExists(atPath: urlCache.path()) {
			if let data = try? Data(contentsOf: urlCache) {
				cachedImage = UIImage(data: data)
			}
		} else {
			Task {
				await getNetworkImage(url: url)
			}
		}
	}
	
	/// Descarga la imagen desde la red utilizando `ImageDownloader` y la asigna a `cachedImage`.
	/// - Parámetros:
	///   - url: La URL de la imagen a descargar.
	/// - Errores:
	///   - Si ocurre un error durante la descarga, se imprime en la consola.
	private func getNetworkImage(url: URL) async {
		do {
			cachedImage = try await ImageDownloader.shared.getImage(url: url)
		} catch {
			print("Error getting image by network: \(error.localizedDescription)")
		}
	}
}
