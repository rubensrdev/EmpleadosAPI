//
//  Empleado.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 6/12/24.
//

import Foundation

struct Empleado: Identifiable, Hashable {
    enum Departamento: String, CaseIterable {
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
    }

    enum Genero: String, CaseIterable {
        case male = "Male"
        case female = "Female"
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


