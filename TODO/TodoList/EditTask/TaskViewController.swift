//
//  TodoController.swift
//  TODO
//
//  Created by Durgasunil Velicheti on 8/2/22.
//

import Foundation
import SnapKit
import UIKit
import TODOKit

/// View Controller to Edit and Add Tasks to the Todo list
///
/// Confirms to the BaseViewController.
class TaskViewController: BaseViewController {
    let viewModel: TaskViewModel
    
    private var taskDescriptionLabel = UILabel()
    private var taskDescriptionTextView = UITextView()
    private var markTaskCompleteLabel = UILabel()
    private var completeTaskButton = CompleteTaskButton()
    
    init(viewModel: TaskViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setEditing(true, animated: true)
    }
    
    override func constructView() {
        super.constructView()
        
        view.backgroundColor = .secondarySystemBackground
        
        if viewModel.isAddingNewTodo {
            let addTaskNavigationItemTitle = NSLocalizedString("AddTask NavigationItem title",
                                                               tableName: "EditTask",
                                                               comment: "Localized string for Add Task navigationItem title")
            navigationItem.title = addTaskNavigationItemTitle
        } else {
            let editTaskNavigationItemTitle = NSLocalizedString("EditTask NavigationItem title",
                                                                tableName: "EditTask",
                                                                comment: "Localized string for Edit Task navigationItem title")
            navigationItem.title = editTaskNavigationItemTitle
        }
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        let taskDescriptionLabelString = NSLocalizedString("TaskDescription Lable text",
                                                            tableName: "EditTask",
                                                            comment: "Localized string for TaskDescription Lable text")
        taskDescriptionLabel.text = taskDescriptionLabelString
        taskDescriptionLabel.textColor = .secondaryLabel
        
        taskDescriptionTextView.text = viewModel.todoItem.taskDescription
        taskDescriptionTextView.font = UIFont.preferredFont(forTextStyle: .body)
        taskDescriptionTextView.backgroundColor = .systemBackground
        taskDescriptionTextView.isScrollEnabled = true
        
        let markTaskCompleteLabelString = NSLocalizedString("MarkTaskComplete Lable text",
                                                            tableName: "EditTask",
                                                            comment: "Localized string for MarkTaskComplete Lable ")
        markTaskCompleteLabel.text = markTaskCompleteLabelString
        markTaskCompleteLabel.textColor = .secondaryLabel
        
        completeTaskButton.completed = viewModel.todoItem.isCompleted
        completeTaskButton.addTarget(self, action: #selector(toggleTaskCompletion), for: .touchUpInside)
    }
    
    override func constructSubviewHierarchy() {
        super.constructSubviewHierarchy()
        
        view.addSubview(taskDescriptionLabel)
        view.addSubview(taskDescriptionTextView)
        view.addSubview(markTaskCompleteLabel)
        view.addSubview(completeTaskButton)
    }
    
    override func constructSubviewLayoutConstraints() {
        super.constructSubviewLayoutConstraints()
        
        taskDescriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.left.equalToSuperview().offset(15)
        }
        
        taskDescriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(taskDescriptionLabel.snp.bottom).offset(10)
            make.left.equalTo(taskDescriptionLabel)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(250)
        }
        
        markTaskCompleteLabel.snp.makeConstraints { make in
            make.left.equalTo(taskDescriptionLabel)
            make.top.equalTo(taskDescriptionTextView.snp.bottom).offset(50)
        }
        
        completeTaskButton.snp.makeConstraints { make in
            make.centerY.equalTo(markTaskCompleteLabel)
            make.left.equalTo(markTaskCompleteLabel.snp.right).offset(10)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            prepareForEditing()
            taskDescriptionTextView.isEditable = true
            taskDescriptionTextView.becomeFirstResponder()
        } else {
            do {
                try updateTodoModel()
            } catch RealmError.failedToSave(let message) {
                print("failed to update the task with a realm error: \(message)")
                let failedToSaveErrorMessage = NSLocalizedString("Failed to update task in realm message",
                                                                tableName: "EditTask",
                                                                comment: "Localized string for realm save error ")
                showError(failedToSaveErrorMessage)
            } catch {
                print("failed to update the task with error: \(error.localizedDescription)")
            }
        }
    }
    
    private func prepareForEditing() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelEdit))
    }
    
    @objc func didCancelEdit() {
        if viewModel.isAddingNewTodo {
            self.dismiss(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func toggleTaskCompletion() {
        completeTaskButton.completed.toggle()
    }
    
    /// Updates the todoTask which is being edited/ added
    ///
    /// Updates the todoTask either by adding a new task or updating its properties
    /// 1. description,
    /// 2. completionStatus.
    private func updateTodoModel() throws {
        let newDescription = taskDescriptionTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let newTaskStatus = completeTaskButton.completed
        
        // Handle the case when description is empty
        guard !newDescription.isEmpty else {
            showError("Description for Task cannot be empty", shouldDismiss: false)
            setEditing(true, animated: true)
            return
        }
        
        if viewModel.isAddingNewTodo {
            viewModel.todoItem = TodoItem(description: newDescription, isCompleted: newTaskStatus)
            try viewModel.addTodo()
            self.dismiss(animated: true)
        } else {
            viewModel.updateTodo(withNewdescription: newDescription, status: newTaskStatus)
            navigationController?.popViewController(animated: true)
        }
    }
}
