//
//  TaskListViewModel.swift
//  TODO
//
//  Created by Durgasunil Velicheti on 7/31/22.
//

import Combine
import RealmSwift
import TODOKit

class TaskListViewModel {
    private var realmManager: RealmProvider
    @Published var syncComplete = false
    
    var todoRealm: Realm {
        realmManager.todoRealm
    }
    
    init(realmManager: RealmProvider) {
        self.realmManager = realmManager
    }
    
    var tasksList: Results<TodoItem> {
        return getAllTasks()
    }
    
    func getAllTasks() -> Results<TodoItem> {
        return todoRealm.objects(TodoItem.self).sorted(byKeyPath: "createdDate", ascending: false)
    }
    
    func getTask(by id: String) -> TodoItem? {
        return todoRealm.objects(TodoItem.self).filter { $0.id == id }.first
    }
    
    func deleteTask(by id: String) {
        guard let item  = getTask(by: id) else {
            return
        }
        
        try! todoRealm.write {
            todoRealm.delete(item)
        }
    }
}
