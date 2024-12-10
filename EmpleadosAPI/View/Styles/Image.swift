//
//  ImageExtension.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 10/12/24.
//

import SwiftUI

extension Image {
	func employeeListImgStyle() -> some View {
		self
			.resizable()
			.scaledToFit()
			.frame(maxWidth: 80)
			.background {
				Color(white: 0.9)
			}
			.clipShape(.circle)
			.shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
	}
}
