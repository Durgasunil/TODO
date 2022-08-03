//
//  ViewController.swift
//  TODO
//
//  Created by Durgasunil Velicheti on 7/31/22.
//

import Combine
import SnapKit
import TODOKit
import UIKit

/// Displays Tasks in a UICollectionViewCompositional Layout
///
///  The collectionView displays the tasks in two sections
///    1. InProgress
///    2. Completed
///

public let onItemUpdatedPublisher = PassthroughSubject<TodoItem.ID?, Never>()

class TaskListViewController: UICollectionViewController {
    var viewModel: TaskListViewModel
    
    var spinner = UIActivityIndicatorView(style: .large)
    var datasource: DataSource!
    private var cancellables: Set<AnyCancellable> = []
    
    init(collectionViewLayout: UICollectionViewCompositionalLayout, viewModel: TaskListViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        constructView()
        constructSubViewHierarchy()
        constructSubViewLayoutConstraints()
        
        // observer item updates and reload only the items which have changed.
        onItemUpdatedPublisher
            .sink { [weak self] id in
                if let id = id {
                    self?.updateSnapshot(reloading: [id])
                } else {
                    self?.updateSnapshot()
                }                
            }.store(in: &cancellables)
        
        updateSnapshot()
    }
    
    func constructView() {
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistration)
        
        datasource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: TodoItem.ID) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        collectionView.dataSource = datasource
        spinner.hidesWhenStopped = true
    }
    
    func constructSubViewHierarchy() {
        view.addSubview(spinner)
    }
    
    func constructSubViewLayoutConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let task = viewModel.tasksList[indexPath.item]
        showDetails(for: task)
        return false
    }
}

private extension TaskListViewController {
    func cellRegistration(cell: UICollectionViewListCell, indexPath: IndexPath, id: TodoItem.ID)  {
        guard let task = viewModel.getTask(by: id) else {
            return
        }
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.secondaryText = task.taskDescription
        contentConfiguration.secondaryTextProperties.color = task.isCompleted ? .systemRed : UIColor.label
        cell.contentConfiguration = contentConfiguration
    }
    
    func showDetails(for todoItem: TodoItem) {
        let realmManager = RealmManager(realmConfig: RealmConfiguration.persistentRealmConfiguration)
        let viewModel = TaskViewModel(todoItem: todoItem, realmManager: realmManager)
        
        let viewController = TaskViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension TaskListViewController {
    func bindViewModel() {
        viewModel.$syncComplete
            .receive(on: DispatchQueue.main)
            .sink { [weak self] syncCompleted in
                if syncCompleted {
                    self?.updateSnapshot()
                }
            }
            .store(in: &cancellables)
    }
}

