//
//  UIButton+Configuration.swift
//  Movie
//
//  Created by taekki on 2022/08/19.
//

import UIKit

extension UIButton.Configuration {
    
    static func netflixStyle(title: String, image: UIImage? = nil) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.titleAlignment = .center
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = .white
        if let image = image {
            configuration.image = image
            configuration.imagePlacement = .leading
            configuration.imagePadding = 8
        }
        return configuration
    }
}
