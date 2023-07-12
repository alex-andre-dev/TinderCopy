//
//  CombineViewController.swift
//  Tinder
//
//  Created by Alexandre  Machado on 11/07/23.
//

import UIKit

enum Action {
    case like
    case superlike
    case deslike
}

class CombineViewController: UIViewController {
    
    var users: [User] = []
    
    var deslikeButton: UIButton = .iconFooter(named: "icone-deslike")
    var likeButton: UIButton = .iconFooter(named: "icone-like")
    var superlikeButton: UIButton = .iconFooter(named: "icone-superlike")
    
    var profileButton: UIButton = .iconMenu(named: "icone-perfil")
    var chatButton:UIButton = .iconMenu(named: "icone-chat")
    var logobutton: UIButton = .iconMenu(named: "icone-logo")
    
    override func viewDidLoad() {
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.systemGroupedBackground
        
        let loading = Loading(frame: view.frame)
        view.insertSubview(loading, at: 0)
        
        addFooter()
        addHeader()
        searchUsers()
    }
    
    func searchUsers() {
        UserService.shared.searchUsers{ (users, error) in
            if let users = users {
                DispatchQueue.main.async {
                    self.users = users
                    self.addCards()
                }
            }
        }
    }
}

extension CombineViewController{
 
    func addHeader(){
        
        let window = UIApplication.shared.windows.first { $0.isKeyWindow}
        let top: CGFloat = window?.safeAreaInsets.top ?? 44
        
        let stackView = UIStackView(arrangedSubviews: [profileButton,logobutton,chatButton])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        
        stackView.fill(top: view.topAnchor,
                       leading: view.leadingAnchor,
                       trailing: view.trailingAnchor,
                       bottom: nil,
                       padding: .init(top: top, left: 16, bottom: 0, right: 16))
    }
    
    func addFooter(){
        let stackView = UIStackView(arrangedSubviews: [UIView(),deslikeButton,superlikeButton,likeButton,UIView()])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        
        stackView.fill(top: nil,
                       leading: view.leadingAnchor,
                       trailing: view.trailingAnchor,
                       bottom: view.bottomAnchor,
                       padding: .init(top: 0, left: 16, bottom: 34, right: 16))
        
        deslikeButton.addTarget(self, action: #selector(deslike), for: .touchUpInside)
        superlikeButton.addTarget(self, action: #selector(superlike), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(like), for: .touchUpInside)

    }
}

extension CombineViewController {
    func addCards(){
        
        for user in users {
            let card = CombineCardView()
            card.user = user
            card.tag = user.id
            let gesture = UIPanGestureRecognizer()
            gesture.addTarget(self, action: #selector(handleCard))
            card.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 32, height: view.bounds.height * 0.7)
            card.addGestureRecognizer(gesture)
            view.insertSubview(card, at: 1)
            card.center = view.center
            card.callback = { (data) in
                self.seeDetails(user: data)
            }
        }
    }
    
    func removeCard(card: UIView){
        card.removeFromSuperview()
        self.users = self.users.filter({ (user) -> Bool in
            return user.id != card.tag
        })
    }
    
    func checkMatch(user: User){
        if user.match {
            let matchViewController = MatchViewController()
            matchViewController.modalPresentationStyle = .fullScreen
            matchViewController.user = user
            self.present(matchViewController, animated: true)
        }
    }
    
    func seeDetails(user:User){
        let vc = DetailViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.user = user
        vc.callback = { (user, action) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                if action == .deslike {
                    self.deslike()
                } else {
                    self.like()
                }
            }
            
        }
        self.present(vc, animated: true, completion: nil)
    }
}

extension CombineViewController {
    @objc func  handleCard (_ gesture: UIPanGestureRecognizer) {
        if let card = gesture.view as? CombineCardView {
            let point  = gesture.translation(in: view)
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            let rotationAngle = point.x / view.bounds.width * 0.4
            
            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
            if point.x > 0 {
                card.likeImageView.alpha = rotationAngle * 5
                card.deslikeImgeView.alpha = 0
            } else {
                card.deslikeImgeView.alpha = -rotationAngle * 5
                card.likeImageView.alpha = 0
            }
            
            if gesture.state == .ended {
                if card.center.x > self.view.bounds.width + 50 {
                    self.animateCard(rotationAngle: rotationAngle, action: .like)
                    return
                }
                
                if card.center.x < -50{
                    self.animateCard(rotationAngle: rotationAngle, action: .deslike)
                    return
                }
                
                UIView.animate(withDuration: 0.2){
                card.center = self.view.center
                card.transform = .identity
                card.deslikeImgeView.alpha = 0
                card.likeImageView.alpha = 0
                }
            }
        }
    }
    
    @objc func deslike(){
        animateCard(rotationAngle: -0.4, action: .deslike)
    }
    
    @objc func like(){
        animateCard(rotationAngle: 0.4, action: .like)
    }
    
    @objc func superlike(){
        animateCard(rotationAngle: 0, action: .superlike)
    }
    
    func animateCard(rotationAngle: CGFloat, action: Action){
        if let user = self.users.first {
            for view in self.view.subviews {
                if view.tag == user.id {
                    if let card = view as? CombineCardView {
                        
                        let center: CGPoint
                        var like: Bool
                        
                        switch action {
                        case .like:
                            center = CGPoint(x: card.center.x + self.view.bounds.width, y: card.center.y + 50)
                            like = true
                        case .deslike:
                            center = CGPoint(x: card.center.x - self.view.bounds.width, y: card.center.y + 50)
                            like = false
                        case .superlike:
                            center = CGPoint(x: card.center.x , y: card.center.y - self.view.bounds.height)
                            like = true
                        }
                        
                        UIView.animate(withDuration: 0.4, animations: {
                            card.center = center
                            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
                            card.deslikeImgeView.alpha = like == false ? 1 : 0
                            card.likeImageView.alpha = like == true ? 1 : 0

                        }, completion: {
                            (_) in
                            
                            if like {
                                self.checkMatch(user: user)
                            }
                            
                            self.removeCard(card: card)
                        })
                        
                    }
                }
            }
        }
    }
}
