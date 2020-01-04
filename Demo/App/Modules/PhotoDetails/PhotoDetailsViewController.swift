//
//  PhotoDetailsViewController.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class PhotoDetailsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var commentsCountLabel: UILabel!

    private let viewModel: PhotoDetailsViewOutput
    private let bag = DisposeBag()
    
    // MARK: - Initialization
    
    init(with viewOutput: PhotoDetailsViewOutput) {
        self.viewModel = viewOutput
        super.init(nibName: nil, bundle: nil)
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

private extension PhotoDetailsViewController {
    func setupUI() {
        title = R.string.localizable.photosDetails()
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        userNameLabel.font = .systemFont(ofSize: 12)
        commentsCountLabel.font = .systemFont(ofSize: 14)
    }
    
    func setupObservation() {
        viewModel.showLoading.subscribeOnMain(onNext: { [weak self] show in
            if show {
                self?.startActivityIndicator()
            } else {
                self?.stopActivityIndicator()
            }
        }).disposed(by: bag)
        
        viewModel.error.subscribeOnMain(onNext: { [weak self] error in
            guard let error = error else { return }
            self?.showAlert(message: error.localizedDescription, actionText: R.string.localizable.commonOk())
        }).disposed(by: bag)
        
        viewModel.configuration.subscribeOnMain(onNext: { [weak self] configuration in
            self?.configure(configuration)
        }).disposed(by: bag)
    }
    
    func configure(_ configuration: PhotoDetailsViewConfiguration?) {
        titleLabel.text = configuration?.title
        userNameLabel.text = configuration?.userName
        commentsCountLabel.text = configuration?.commentsCount
        imageView.setImageResource(configuration?.imageResource)
    }
}
