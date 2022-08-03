//
//  TasksViewController.swift
//  TODO
//
//  Created by Durgasunil Velicheti on 7/31/22.
//

import UIKit
import TODOKit

class TasksViewController: BaseViewController {
    var taskListController: TaskListViewController!
    var layoutListConfiguration: UICollectionLayoutListConfiguration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func constructView() {
        super.constructView()
        view.backgroundColor = .systemBackground
        
        layoutListConfiguration = TaskListLayoutBuilder.createTaskLayoutListConfiguration()
        
        layoutListConfiguration.trailingSwipeActionsConfigurationProvider = { [weak self] (_ indexPath: IndexPath) -> UISwipeActionsConfiguration? in
            
            let deleteButtonTitleString = NSLocalizedString("Delete Button Title", tableName: "TaskList", comment: "Localized string for delete button title")
            
            let deleteAction = UIContextualAction(style: .destructive, title: deleteButtonTitleString) { action, view, completion in
                self?.delete(at: indexPath)
                completion(true)
            }
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        
        let layout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout.list(using: layoutListConfiguration)
        let realmManager = RealmManager(realmConfig: RealmConfiguration.persistentRealmConfiguration)
        let taskListViewModel = TaskListViewModel(realmManager: realmManager)
        taskListController = TaskListViewController(collectionViewLayout: layout, viewModel: taskListViewModel)
    }
    
    override func constructSubviewHierarchy() {
        super.constructSubviewHierarchy()
        
        let taskListViewTitleString = NSLocalizedString("TaskList NavigationItem Title", tableName: "TaskList", comment: "Localized string for TaskList title")
        navigationItem.title = taskListViewTitleString
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_:)))
        addButton.accessibilityLabel = NSLocalizedString("Add Task", comment: "Add button accessibility label")
        navigationItem.rightBarButtonItem = addButton
        
        view.addSubview(taskListController.view)
        addChild(taskListController)
    }
    
    override func constructSubviewLayoutConstraints() {
        super.constructSubviewLayoutConstraints()
        
        taskListController.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
}
