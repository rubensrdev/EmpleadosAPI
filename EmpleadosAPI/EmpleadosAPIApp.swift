//
//  EmpleadosAPIApp.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 6/12/24.
//

import SwiftUI


@MainActor let isIPad = UIDevice.current.userInterfaceIdiom == .pad

@main
struct EmpleadosAPIApp: App {
    var body: some Scene {
        WindowGroup {
            if isIPad {
				EntryViewIPad16()
			} else {
				EntryViewIPhone()
			}
        }
    }
}
