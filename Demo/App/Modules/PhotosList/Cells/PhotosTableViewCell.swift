//
//  PhotosTableViewCell.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

public class PhotoCellConfiguration: CellConfiguration, ClickableCellConfiguration {
    public let viewType: ConfigurableCell.Type = PhotosTableViewCell.self
    public var onClicked: ((IndexPath) -> Void)?
        
    public let title: String
    public let imageResource: ImageResource?
    
    init(title: String,
         imageResource: ImageResource?,
         onClicked: ((IndexPath) -> Void)? = nil) {
        self.onClicked = onClicked
        self.title = title
        self.imageResource = imageResource
    }
}

class PhotosTableViewCell: UITableViewCell {
    
    // MARK: - Private properies
    
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.clipsToBounds = true
    }
}

// MARK: - ConfigurableCell

extension PhotosTableViewCell: ConfigurableCell {
    func configure(_ configuration: CellConfiguration) {
        guard let configuration = configuration as? PhotoCellConfiguration else {
            assertionFailure("Wrong cell configuration")
            return
        }
        titleLabel.text = configuration.title
        photoImageView.setImageResource(configuration.imageResource)
    }
}
