//
//  CombineCardView.swift
//  Tinder
//
//  Created by Alexandre  Machado on 11/07/23.
//

import UIKit

class CombineCardView: UIView {
    
    var user: User? {
        didSet{
            if let user = user {
                pictureImageView.image = UIImage(named: user.picture)
                nameLabel.text = user.name
                ageLabel.text = String(user.age)
                phraseLabel.text = user.phrase
            }
        }
    }
    
    var callback: ((User) -> Void)?
    
    let pictureImageView: UIImageView = .pictureImageView()
    
    let nameLabel : UILabel = .textBoldLabel(32, textColor: .white)
    
    let ageLabel : UILabel = .textLabel(28, textColor: .white)
    
    let phraseLabel: UILabel = .textLabel(18, textColor: .white, numberOfLines: 2)
    
    let deslikeImgeView: UIImageView = .iconCard(named: "card-deslike")
    
    let likeImageView: UIImageView = .iconCard(named: "card-like")
    
    let personalDataStackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 12
        return sv
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 8
        clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(clicked))
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(tap)

        nameLabel.addShadow()
        ageLabel.addShadow()
        phraseLabel.addShadow()
    }
    
    private func setupHierarchy() {
        personalDataStackView.addArrangedSubview(nameLabel)
        personalDataStackView.addArrangedSubview(ageLabel)
        personalDataStackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(personalDataStackView)
        stackView.addArrangedSubview(phraseLabel)
        addSubview(pictureImageView)
        addSubview(stackView)
        addSubview(deslikeImgeView)
        addSubview(likeImageView)

    }
    
    private func setupConstraints(){
        pictureImageView.fillEntireView(view: self)
        
        stackView.fill(top: nil,
                       leading: leadingAnchor,
                       trailing: trailingAnchor,
                       bottom: bottomAnchor,
                       padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
        deslikeImgeView.fill(top: topAnchor,
                             leading: nil,
                             trailing: trailingAnchor,
                             bottom: nil,
                             padding: .init(top: 20, left: 0, bottom: 0, right: 20))
        
        likeImageView.fill(top: topAnchor,
                           leading: leadingAnchor,
                           trailing: nil,
                           bottom: nil,
                           padding: .init(top: 20, left: 20, bottom: 0, right: 0))
    }
    
    @objc func clicked(){
        if let user = self.user {
            self.callback?(user)
        }
    }
    
}
