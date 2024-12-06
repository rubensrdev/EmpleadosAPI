//
//  EmpleadoDTO.swift
//  EmpleadosAPI
//
//  Created by Rubén Segura Romo on 6/12/24.
//

import Foundation

struct EmpleadoDTO: Codable {
    
    struct Departamento: Codable {
        let id: Int
        let name: String
    }
    
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
