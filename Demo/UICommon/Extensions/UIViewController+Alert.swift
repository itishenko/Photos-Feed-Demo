//
//  UIViewController+Alert.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func showAlert(_ title: String? = nil, message: String? = nil, style: UIAlertController.Style = .alert, actionText: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: style)
        alertView.addAction(UIAlertAction(title: actionText, style: .default, handler: handler))
        present(alertView, animated: true, completion: nil)
    }
}
