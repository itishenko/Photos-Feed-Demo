//
//  BaseTableViewAdapter.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import UIKit

public protocol BaseTableViewAdapterProtocol {
    var didSelectRowAt: ((IndexPath)->())? { get set }
}

open class BaseTableViewAdapter: NSObject, BaseTableViewAdapterProtocol {
    open weak var tableView: UITableView!
    public private(set) var descriptors = [SectionConfiguration]()
    
    public var didSelectRowAt: ((IndexPath)->())?

    public init(_ tableView: UITableView) {
        self.tableView = tableView
        super.init()

        tableView.delegate = self
        tableView.dataSource = self
    }

    public func reloadWith(descriptors: [SectionConfiguration]) {
        self.descriptors = descriptors
        tableView.reloadData()
    }
}

public extension BaseTableViewAdapter {
    
    func indexPath(for cellConfiguration: CellConfiguration) -> IndexPath? {
        for (sectionIndex, section) in descriptors.enumerated() {
            for (cellIndex, configuration) in section.rows.enumerated() where configuration === cellConfiguration {
                return IndexPath(row: cellIndex, section: sectionIndex)
            }
        }
        return nil
    }
}

extension BaseTableViewAdapter: UITableViewDataSource {
    open func numberOfSections(in tableView: UITableView) -> Int {
        return descriptors.count
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard descriptors.count > section else {
            return 0
        }
        return descriptors[section].rows.count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard descriptors.count > indexPath.section, descriptors[indexPath.section].rows.count > indexPath.row else {
            return UITableViewCell()
        }
        
        let descriptor = descriptors[indexPath.section].rows[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: descriptor.viewType.reuseIdentifier, for: indexPath) as? ConfigurableCell else {
            return UITableViewCell()
        }

        cell.configure(descriptor)

        return cell
    }
    
}

extension BaseTableViewAdapter: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard descriptors.count > indexPath.section, descriptors[indexPath.section].rows.count > indexPath.row else {
            return 0
        }
        return descriptors[indexPath.section].rows[indexPath.row].height
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerDescriptor = descriptors[section].header,
              let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerDescriptor.viewType.reuseIdentifier) as? ConfigurableHeaderFooterView else {
            return nil
        }

        header.configure(headerDescriptor)
        return header
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard descriptors.count > section, let headerDescriptor = descriptors[section].header else {
            return 0
        }
        return headerDescriptor.height
    }

    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerDescriptor = descriptors[section].footer,
              let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerDescriptor.viewType.reuseIdentifier) as? ConfigurableHeaderFooterView else {
            return nil
        }

        footer.configure(footerDescriptor)
        return footer
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard descriptors.count > section, let footerDescriptor = descriptors[section].footer else {
            return 0
        }
        return footerDescriptor.height
    }

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAt?(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
                
        guard descriptors.count > indexPath.section,
            descriptors[indexPath.section].rows.count > indexPath.row,
            let clickableCell = descriptors[indexPath.section].rows[indexPath.row] as? ClickableCellConfiguration else { return }
        
        clickableCell.onClicked?(indexPath)
    }
}

