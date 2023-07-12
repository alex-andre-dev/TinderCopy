//
//  UIImageView.swift
//  Tinder
//
//  Created by Alexandre  Machado on 11/07/23.
//

import UIKit

extension UIImageView {
    
    static func pictureImageView(named: String? = nil) -> UIImageView {
        let imageView = UIImageView()
        if let named = named {
            imageView.image = UIImage(named: named)
        }
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    static func iconCard (named: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: named)
        imageView.size(size: .init(width: 70, height: 70))
        imageView.alpha = 0
        return imageView
    }
}
