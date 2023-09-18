//
//  Student.swift
//  lesson16
//
//  Created by Максим Оліярник on 22.03.2023.
//

import Foundation


struct Students : Codable {
    let students : [Student]
}

struct Student : Codable {
    let name : String
    let email : String
    let logo : URL
}
