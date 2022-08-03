//
//  TaskListViewModel.swift
//  TODOTests
//
//  Created by Durgasunil Velicheti on 8/3/22.
//

import Foundation
import TODOKit
@testable import TODO

extension TaskListViewModel {
    func addTaskToRealm() {
        for item in TodoItem.sampleData {
            if todoRealm.isInWriteTransaction {
                todoRealm.add(item)
            } else {
                try! todoRealm.write {
                    todoRealm.add(item)
                }
            }
        }
        syncComplete = true
    }
}
