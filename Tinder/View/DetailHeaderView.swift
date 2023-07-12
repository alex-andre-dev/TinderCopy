//
//  DetailHeaderView.swift
//  Tinder
//
//  Created by Alexandre  Machado on 12/07/23.
//

import UIKit

class DetailHeaderView: UICollectionReusableView {
    
    var user: User? {
        didSet {
            if let user = user {
                pictureImageView.image = UIImage(named: user.picture)
            }
        }
    }
    
    var pictureImageView: UIImageView = .pictureImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupHierarchy()
        setupConstraints()
    }
    
    func setupView(){
        backgroundColor = .systemBlue

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
