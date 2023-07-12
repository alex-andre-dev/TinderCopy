//
//  UIStackView.swift
//  Tinder
//
//  Created by Alexandre  Machado on 12/07/23.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]){
        views.forEach({ (view) in
            self.addArrangedSubview(view)
        })
    }
}
