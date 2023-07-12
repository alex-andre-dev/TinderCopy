//
//  DetailProfileCollectionViewCell.swift
//  Tinder
//
//  Created by Alexandre  Machado on 12/07/23.
//

import UIKit

class DetailProfileCollectionViewCell: UICollectionViewCell {
    
    var user: User? {
        didSet {
            if let user = user {
                ageLabel.text = String(user.age)
                nameLabel.text = user.name
                phraseLabel.text = user.phrase
            }
        }
    }
    
    let nameLabel : UILabel = .textBoldLabel(32)
    let ageLabel : UILabel = .textLabel(28)
    let phraseLabel: UILabel = .textLabel(18, numberOfLines: 2)
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 12
        return sv
    }()
    
    let stackView2: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()

    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
        setupHierarchy()
        setupConstraints()
    }
    
    func setupViews() {
        
    }
    func setupHierarchy() {
        stackView.addArrangedSubviews([nameLabel, ageLabel, UIView()])
        stackView2.addArrangedSubviews([stackView, phraseLabel])
        addSubview(stackView2)
    }
    func setupConstraints(){
        stackView2.fillEntireView(view: self, padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

