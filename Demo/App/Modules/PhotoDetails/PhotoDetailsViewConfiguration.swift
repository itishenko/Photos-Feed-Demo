//
//  PhotoDetailsViewConfiguration.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

struct PhotoDetailsViewConfiguration {
    
    let imageResource: ImageResource?
    let title: String
    let userName: String?
    let commentsCount: String
    
    init(imageResource: ImageResource?,
         title: String,
         userName: String?,
         commentsCount: String) {
        self.imageResource = imageResource
        self.title = title
        self.userName = userName
        self.commentsCount = commentsCount
    }
}
