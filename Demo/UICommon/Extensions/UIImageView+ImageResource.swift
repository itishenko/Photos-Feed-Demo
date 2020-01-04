//
//  ImageResource.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit
import Kingfisher

public enum ImageResource {
    case image(UIImage)
    case url(URL)
}

public extension UIImageView {
    
    func setImageResource(_ imageResource: ImageResource?) {
        guard let imageResource = imageResource else {
            kf.cancelDownloadTask()
            self.image = nil
            return
        }
        
        switch imageResource {
        case .image(let image):
            kf.cancelDownloadTask()
            self.image = image
            
        case .url(let url):
            kf.indicatorType = .activity
            kf.setImage(with: url)
        }
    }
}
