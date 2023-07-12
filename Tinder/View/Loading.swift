//
//  Loading.swift
//  Tinder
//
//  Created by Alexandre  Machado on 11/07/23.
//

import UIKit


class Loading: UIView {
    
    let loadView: UIView = {
        let load = UIView()
        load.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        load.backgroundColor = UIColor(red: 218/255, green: 99/255, blue: 111/255, alpha: 1)
        load.layer.cornerRadius = 50
        load.layer.borderWidth = 1
        load.layer.borderColor = UIColor.red.cgColor
        return load
    }()
    
    let profileImageview: UIImageView = {
        let img = UIImageView()
        img.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        img.layer.cornerRadius = 50
        img.layer.borderWidth = 5
        img.layer.borderColor = UIColor.white.cgColor
        img.clipsToBounds = true
        img.image = UIImage(named: "perfil")
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(loadView)
        addSubview(profileImageview)
        loadView.center = center
        profileImageview.center = center
        animate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate() {
        UIView.animate(withDuration: 1.3, animations: {
            
            self.loadView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
            self.loadView.center = self.center
            self.loadView.layer.cornerRadius = 125
            self.loadView.alpha = 0.3
            
        }) { (_) in
            
            self.loadView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            self.loadView.center = self.center
            self.loadView.layer.cornerRadius = 50
            self.loadView.alpha = 1
            
            self.animate()


        }
    }
    
}
