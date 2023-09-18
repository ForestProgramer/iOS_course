//
//  Lesson.swift
//  lesson16
//
//  Created by Максим Оліярник on 22.03.2023.
//

import Foundation

struct Lessons : Codable {
    let lessons : [Lesson]
}

struct Lesson : Codable {
    let name : String
    let hours : String
}
