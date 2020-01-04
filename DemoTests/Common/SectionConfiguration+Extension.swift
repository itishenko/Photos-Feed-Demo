//
//  SectionConfiguration+Extension.swift
//  DemoTests
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit
import Demo

extension SectionConfiguration {
    
    func clickRow(with index: Int) {
        guard rows.count > index, let cell = rows[index] as? ClickableCellConfiguration else { return }
        cell.onClicked?(IndexPath(row: index, section: 0))
    }
}
