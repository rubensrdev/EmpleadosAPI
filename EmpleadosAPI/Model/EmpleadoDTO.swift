//
//  EmpleadoDTO.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 6/12/24.
//

import Foundation

/// Estructura que modela el tipo Empleado que será recibida del API REST en las solicitudes
struct EmpleadoDTO: Codable {
    
	/// Estructura que modela el departamento al que pertenece un empleado
    struct Departamento: Codable {
        let id: Int
        let name: String
    }
    
	/// Estructura que modela el Género de un empleado
    struct Genero: Codable {
        let id: Int
        let gender: String
    }
    
    let id: Int
    let firstName: String
    let lastName: String
    let avatar: URL?
    let email: String
    let username: String
    let zipcode: String
    let address: String
    let department: Departamento
    let gender: Genero
}

extension EmpleadoDTO {
	/// Propiedad calculada a partir de un EmpleadoDTO y que construye un modelo del tipo Empleado
    var toEmpleado: Empleado? {
        
        guard let departamento = Empleado.Departamento(rawValue: department.name),
              let genero = Empleado.Genero(rawValue: gender.gender) else {
            return nil
        }
        
        return Empleado(
            id: id,
            firstName: firstName,
            lastName: lastName,
            avatar: avatar,
            email: email,
            username: username,
            address: address,
            zipcode: zipcode,
            department: departamento,
            gender: genero
        )
    }
}
