//
//  EmpleadoRow.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 10/12/24.
//
import SwiftUI

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
			EmpleadoAsyncImage(empleado: empleado)
		}
	}
}

#Preview {
	EmpleadoRow(empleado: .empleadoPreview)
}
