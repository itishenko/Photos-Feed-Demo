//
//  PhotosListViewController.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class PhotosListViewController: UITableViewController {
    
    // MARK: - Private Properties
    
    private lazy var adapter = PageableTableViewAdapter(tableView)
    private let viewModel: PhotosListViewOutput
    private let bag = DisposeBag()
    private var placeholder = UILabel()
    
    // MARK: - Initialization
    
    init(with viewOutput: PhotosListViewOutput) {
        self.viewModel = viewOutput
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupUI()
        setupObservation()
    }
}

// MARK: - Private Methods

private extension PhotosListViewController {
    
    func setupUI() {
        title = R.string.localizable.photosList()
        setupTableView()
        setupPlaceholder()
    }
    
    func setupTableView() {
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = UITableView.automaticDimension
        
        tableView.register(PhotosTableViewCell.self)
            
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self,
                                            action: #selector(PhotosListViewController.refresh(_:)),
                                            for: .valueChanged)
        
        adapter.onReachEnd = { [weak self] in
            self?.viewModel.reachEnd()
        }
    }
    
    func setupPlaceholder() {
        placeholder.text = viewModel.emptyListText
        placeholder.isHidden = true
        view.addSubview(placeholder)
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        placeholder.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        placeholder.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupObservation() {
        viewModel.showLoading.subscribeOnMain(onNext: { [weak self] show in
            self?.showLoading(show)
        }).disposed(by: bag)
        
        viewModel.error.subscribeOnMain(onNext: { [weak self] error in
            guard let error = error else { return }
            self?.showAlert(message: error.localizedDescription, actionText: R.string.localizable.commonOk())
        }).disposed(by: bag)
        
        viewModel.configurations.subscribeOnMain(onNext: { [weak self] descriptors in
            self?.adapter.reloadWith(descriptors: descriptors)
        }).disposed(by: bag)
        
        viewModel.showPlaceholder.subscribeOnMain(onNext: { [weak self] show in
            self?.placeholder.isHidden = !show
        }).disposed(by: bag)
    }
    
    func showLoading(_ show: Bool){
        if show {
            startActivityIndicator()
        } else {
            stopActivityIndicator()
            if let refreshControl = tableView.refreshControl, refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
        }
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        viewModel.refresh()
    }
}
