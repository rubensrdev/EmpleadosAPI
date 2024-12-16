//
//  ModelAPI.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 16/12/24.
//

import Foundation

struct EmpleadosUpdate: Codable {
	var id: Int
	var username: String?
	var firstName: String?
	var lastName: String?
	var email: String?
	var address: String?
	var avatar: String?
	var zipcode: String?
	var department: String?
	var gender: String?
}

extension Empleado {
	var update: EmpleadosUpdate {
		EmpleadosUpdate(id: id, username: username, firstName: firstName, lastName: lastName, email: email, address: address, avatar: avatar?.absoluteString, zipcode: zipcode, department: department.rawValue, gender: gender.rawValue)
	}
}
