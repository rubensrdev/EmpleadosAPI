//
//  Empleado.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 6/12/24.
//

import Foundation

/// Representación del modelo Empleado que servirá para la representación de este en la app
struct Empleado: Identifiable, Hashable {
	/// Enumeración con los casos de tipo Departamento que puede tener un empleado
	enum Departamento: String, CaseIterable, Identifiable {
        case accounting = "Accounting"
        case engineering = "Engineering"
        case legal = "Legal"
        case marketing = "Marketing"
        case sales = "Sales"
        case support = "Support"
        case training = "Training"
        case researchAndDevelopment = "Research and Development"
        case businessDevelopment = "Business Development"
        case productManagement = "Product Management"
        case humanResources = "Human Resources"
        case services = "Services"
		
		var id: Self { self }
    }

	/// Enumeración con los casos de tipo Genero que puede tener un empleado
	enum Genero: String, CaseIterable, Identifiable {
        case male = "Male"
        case female = "Female"
		
		var id: Self { self }
    }
    
    let id: Int
    let firstName: String
    let lastName: String
    let avatar: URL?
    let email: String
    let username: String
    let address: String
    let zipcode: String
    let department: Departamento
    let gender: Genero
}

typealias Empleados = [Empleado]

extension Empleado {
	var fullName: String {
		"\(lastName), \(firstName)"
	}
}

