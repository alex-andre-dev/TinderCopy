//
//  DetailPhotosCell.swift
//  Tinder
//
//  Created by Alexandre  Machado on 12/07/23.
//

import UIKit

class DetailPhotosCell: UICollectionViewCell {
    
    let descriptionLabel: UILabel = .textBoldLabel(16)
    
    let slidePhotosVC = SlidePhotosViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupHierarchy()
        setupConstraints()
    }
    
    func setupView(){
        descriptionLabel.text = "fotos recentes do instagram"
    }
    
    func setupHierarchy(){
        addSubview(descriptionLabel)
        addSubview(slidePhotosVC.view)
    }
    
    func setupConstraints(){
        descriptionLabel.fill(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        slidePhotosVC.view.fill(top: descriptionLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
