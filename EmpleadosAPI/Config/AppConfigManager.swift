//
//  AppConfig.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 20/12/24.
//

import Foundation

actor AppConfigManager {
	static let shared = AppConfigManager()
	
	var baseURL: String?
	
	private init() {
		Task {
			try? await setupBaseURL()
		}
	}
	
	private func setupBaseURL() throws {
		guard let propsURL = Bundle.main.url(forResource: "ConfigProps", withExtension: "plist") else { return }
		let data = try Data(contentsOf: propsURL)
		let propsDic = try PropertyListDecoder().decode([String:String].self, from: data)
		baseURL = propsDic["baseURL"]
	}
}
