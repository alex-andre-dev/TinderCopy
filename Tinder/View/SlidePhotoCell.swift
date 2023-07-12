//
//  SlidePhotoCell.swift
//  Tinder
//
//  Created by Alexandre  Machado on 12/07/23.
//

import UIKit

class SlidePhotoCell: UICollectionViewCell {
    
    var pictureImageView: UIImageView = .pictureImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupHierarchy()
        setupConstraints()
    }
    
    func setupView(){
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    func setupHierarchy(){
        addSubview(pictureImageView)
    }
    
    func setupConstraints(){
        pictureImageView.fillEntireView(view: self)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
