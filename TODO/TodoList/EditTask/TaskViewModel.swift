//
//  TodoViewModel.swift
//  TODO
//
//  Created by Durgasunil Velicheti on 8/2/22.
//

import Foundation
import TODOKit


class TaskViewModel {
    var realmManager: RealmProvider
    
    var todoItem: TodoItem
    var isAddingNewTodo: Bool = false
    
    init(todoItem: TodoItem, realmManager: RealmProvider) {
        self.todoItem = todoItem
        self.realmManager = realmManager
    }
    
    func updateTodo(withNewdescription newDescription: String, status: Bool) {        
        try? realmManager.todoRealm.write {
            todoItem.taskDescription = newDescription
            todoItem.isCompleted = status
        }
        onItemUpdatedPublisher.send(todoItem.id)
    }
    
    func addTodo() throws {
        do {
            try realmManager.todoRealm.write {
                realmManager.todoRealm.add(todoItem)
            }
        } catch {
            throw RealmError.failedToSave(error.localizedDescription)
        }
        
        onItemUpdatedPublisher.send(nil)
    }
}
