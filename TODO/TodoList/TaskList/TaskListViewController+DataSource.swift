//
//  TaskListViewController+DataSource.swift
//  TODO
//
//  Created by Durgasunil Velicheti on 7/31/22.
//

import UIKit
import TODOKit

enum TaskListSection: Int {
    case main
}

/// Extends the TaskViewController to provide datasource and methods to update snapshot when the underlying changes
extension TaskListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<TaskListSection, TodoItem.ID>
    typealias Snapshot  = NSDiffableDataSourceSnapshot<TaskListSection, TodoItem.ID>
    
    func updateSnapshot(reloading idsThatChanged: [TodoItem.ID] = []) {
        var snapShot = Snapshot()
        snapShot.appendSections([.main])
        let allTasks = viewModel.getAllTasks()
        
        snapShot.appendItems(allTasks.map { $0.id }, toSection: .main)
        
        if !idsThatChanged.isEmpty {
            snapShot.reloadItems(idsThatChanged)
        }
        
        datasource.apply(snapShot)
    }
    
    func deleteItems(atIndexPath indexPath: IndexPath) {
        guard let id = datasource.itemIdentifier(for: indexPath) else {
            return
        }
        
        viewModel.deleteTask(by: id)        
        
        var snapShot = Snapshot()
        snapShot.appendSections([.main])
        let allTasks = viewModel.getAllTasks()
        
        snapShot.appendItems(allTasks.map { $0.id }, toSection: .main)
        snapShot.deleteItems([id])
        datasource.apply(snapShot)
    }
}
