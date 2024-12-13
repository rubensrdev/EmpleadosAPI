//
//  ImageDownloader.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 10/12/24.
//

import SwiftUI


//  Flujo General de Uso -> Cuando otra parte del programa solicita una imagen:
// 1.	getImage(url:) revisa el cache.
//    2.	Si la imagen se está descargando, espera esa tarea.
//    3.	Si ya está descargada, la devuelve al instante.
//    4.	Si no está, inicia la descarga.
//    5.	Una vez descargada, la guarda a disco y actualiza el estado a .downloaded.
//
// Este enfoque optimiza el rendimiento (evitando descargas repetidas), reduce el consumo de datos y mejora la experiencia
// del usuario al ofrecer imágenes ya en caché.
 
/// Este Actor gestiona la descarga y el caché de imágenes desde una URL de forma asíncrona y segura
/// frente a condiciones de Data Race en un entorno concurrente.
/// - Uso: ImageDownloader se encarga de descargar las imágenes desde la red, manterlas en caché temporalmente en memoria miestras
/// se descargan o están descargadas y finlamnete guardar la imagen descargadas en la memoria del dispositivo para evitar descargar repetidas
/// - Uso de Actor: esto garantiza lque sus propiedades y métodos son serializados garantizando así problemas de concurrencias y Data Race.
actor ImageDownloader {
	static let shared = ImageDownloader()
	
	private enum ImageStatus {
		case downloading(task: Task<UIImage,Error>)
		case downloaded(image: UIImage)
	}
	
	private var cache: [URL: ImageStatus] = [:]
	
	func getImage(url: URL) async throws -> UIImage {
		if let status = cache[url] {
			switch status {
			case .downloading(let task):
				return try await task.value
			case .downloaded(let image):
				return image
			}
		}
		
		let task = Task { try await getNetworkImage(url: url) }
		cache[url] = .downloading(task: task)
	
		do {
			let image = try await task.value //10seg
			cache[url] = .downloaded(image: image)
			try await saveImageToCache(url: url)
			return image
		} catch {
			cache.removeValue(forKey: url)
			throw error
		}
	}
	
	private func getNetworkImage(url: URL) async throws -> UIImage {
		let (data, _) = try await URLSession.shared.data(from: url)
		guard let image = UIImage(data: data) else { throw URLError(.badServerResponse) }
		return image
	}
	
	private func saveImageToCache(url: URL) async throws {
		let imageCache = cache[url]
		let imageName = url.lastPathComponent // ultimo
		let pathCache = URL.cachesDirectory.appending(path: imageName)
		
		
		if case .downloaded(let image) = imageCache,
		   let uiImage = await image.byPreparingThumbnail(ofSize: image.size),
		   let heicData = uiImage.heicData() {
			
			try heicData.write(to: urlDoc(url: pathCache), options: .atomic)
			cache.removeValue(forKey: url)
		}
		
	}
	
	nonisolated func urlDoc(url: URL) -> URL {
		let path = url.deletingPathExtension().appendingPathExtension("heic").lastPathComponent
		return URL.cachesDirectory.appending(path: path)
	}
}
