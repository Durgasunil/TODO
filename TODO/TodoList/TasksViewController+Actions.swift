//
//  TaskListController+Actions.swift
//  TODO
//
//  Created by Durgasunil Velicheti on 7/31/22.
//

import UIKit
import TODOKit

extension TasksViewController {
    
    @objc func didPressAddButton(_ sender: UIBarButtonItem) {
        let newTodo = TodoItem(description: "", isCompleted: false)
        let realmManager = RealmManager(realmConfig: RealmConfiguration.persistentRealmConfiguration)
        let viewModel = TaskViewModel(todoItem: newTodo, realmManager: realmManager)
        viewModel.isAddingNewTodo = true
        let viewController = TaskViewController(viewModel: viewModel)
        
        viewController.navigationItem.title = NSLocalizedString("Add Todo", comment: "Add Todo view controller title")
        let navigationControler = UINavigationController(rootViewController: viewController)
        present(navigationControler, animated: true)
    }    
    
    func delete(at indexPath: IndexPath) {
        taskListController.deleteItems(atIndexPath: indexPath)
    }
}
