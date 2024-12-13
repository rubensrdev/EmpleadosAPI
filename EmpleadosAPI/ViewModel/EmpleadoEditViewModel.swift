//
//  EmpleadoEditViewModel.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 13/12/24.
//

import Foundation

@Observable
final class EmpleadoEditViewModel {
	let empleado: Empleado
	
	init(empleado: Empleado) {
		self.empleado = empleado
	}
}
