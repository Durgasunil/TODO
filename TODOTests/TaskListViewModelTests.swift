//
//  TaskListViewModelTests.swift
//  TODOTests
//
//  Created by Durgasunil Velicheti on 8/3/22.
//

import Foundation
import Combine
import TODOKit
@testable import TODO
import XCTest

class TaskListViewModelTests: XCTestCase {
    var taskListVM: TaskListViewModel = TaskListViewModel(realmManager: RealmManager(realmConfig: RealmConfiguration.inMemoryConfiguration))
    private var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        taskListVM.syncComplete = false
        taskListVM.addTaskToRealm()
        
        let syncCompleteExpectation = XCTestExpectation(description: "Sink Completed")
        
        taskListVM.$syncComplete
            .sink { syncCompleted in
                if syncCompleted {
                    print("--> Tasks loaded Successfully")
                    syncCompleteExpectation.fulfill()
                }
            }.store(in: &cancellables)
        
        XCTWaiter().wait(for: [syncCompleteExpectation], timeout: 5)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testGetAllTasks() throws {
        let tasks = taskListVM.getAllTasks()
        XCTAssertEqual(tasks.count, TodoItem.sampleData.count)
    }
    
    func testGetTaskById() throws {
        let task3 = TodoItem.sampleData[3]
        let retreivedTask = taskListVM.getTask(by: task3.id)
        XCTAssertNotNil(retreivedTask?.id)
        XCTAssertEqual(retreivedTask?.id, task3.id)
    }
}
