//
//  TaskListLayoutBuilder.swift
//  TODO
//
//  Created by Durgasunil Velicheti on 7/31/22.
//

import Foundation
import UIKit

/// provides static methods to build layout for Task List
///
/// GetTaskListLayout method provides the CompositinalListLayout for the Task list
class TaskListLayoutBuilder {
    static func createTaskLayoutListConfiguration() -> UICollectionLayoutListConfiguration {
        var taskListConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        taskListConfiguration.backgroundColor = .systemBackground
        return taskListConfiguration
    }
}
