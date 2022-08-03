//
//  TODOItem.swift
//  TODOTests
//
//  Created by Durgasunil Velicheti on 8/3/22.
//

import Foundation
import TODOKit

extension TodoItem {
    public static var sampleData = [
        TodoItem(description: "Task 1 is a big task with loooots of text which will go on forever and ever and ever and ever."),
        TodoItem(description: "Task 2"),
        TodoItem(description: "Task 3"),
        TodoItem(description: "Task 4"),
        TodoItem(description: "Task 5"),
        TodoItem(description: "Task 6"),
        TodoItem(description: "Task 7", isCompleted: true),
        TodoItem(description: "Task 8")
    ]
}
