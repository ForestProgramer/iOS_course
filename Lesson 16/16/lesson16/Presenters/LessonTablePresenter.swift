//
//  LessonTableViewController.swift
//  testtt
//
//  Created by Volodymyr Rykhva on 28.06.2021.
//

import UIKit

protocol LessonsPresenterProtocol: AnyObject {
    func showLessons(data: Lessons)
}

final class LessonTablePresenter {

    private var lessons: [Lesson] = []

   func updateLessons()->[Lesson]{
        lessons = JsonService.shared.parseLessons()?.lessons ?? []
        
        return lessons
    }
}
