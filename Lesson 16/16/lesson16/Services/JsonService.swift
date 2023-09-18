//
//  JsonService.swift
//  testtt
//
//  Created by Volodymyr Rykhva on 29.06.2021.
//

import Foundation

final class JsonService {

    static let shared = JsonService()
    private let decoder = JSONDecoder()

    private init() {}

    func parseStudents() -> Students? {
        guard
            let jsonData = jsonFile.data(using: .utf8),
            let jsonStudents = try? decoder.decode(Students.self, from: jsonData) else {
            return nil
        }
        return jsonStudents
    }

    func parseLessons() -> Lessons? {
        guard
            let jsonData = jsonFile.data(using: .utf8),
            let jsonLessons = try? decoder.decode(Lessons.self, from: jsonData) else {
            return nil
        }
        return jsonLessons
    }
}
