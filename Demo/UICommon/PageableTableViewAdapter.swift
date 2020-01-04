//
//  PageableTableViewAdapter.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import UIKit

open class PageableTableViewAdapter: BaseTableViewAdapter {
    public var onReachEnd: (() -> Void)?
}

extension PageableTableViewAdapter {

    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard tableView.numberOfSections - 1 <= indexPath.section,
              tableView.numberOfRows(inSection: indexPath.section) - 3 <= indexPath.row else { return }
        onReachEnd?()
    }
}
