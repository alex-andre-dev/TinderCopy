//
//  MatchViewController.swift
//  Tinder
//
//  Created by Alexandre  Machado on 11/07/23.
//

import UIKit

class MatchViewController: UIViewController, UITextFieldDelegate {
    
    var user: User? {
        didSet {
            if let user = user {
                pictureImageView.image = UIImage(named: user.picture)
                messageLabel.text = String(user.name) + " curtiu você também!"
            }
        }
    }
    
    let pictureImageView: UIImageView = .pictureImageView(named: "pessoa-1")
    
    let likeImageView: UIImageView = .pictureImageView(named: "icone-like")
    
    let messageLabel: UILabel = .textBoldLabel(18, textColor: .white, numberOfLines: 1)
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 16
        return sv
    }()
    
    let messageTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Diga algo legal..."
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.textColor = .darkText
        textField.returnKeyType = .google
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 0))
        textField.rightViewMode = .always
        return textField
    }()
    
    let messageSendButton : UIButton = {
        let button = UIButton()
        button.setTitle("Enviar", for: .normal)
        button.setTitleColor(UIColor(red: 62/255, green: 163/255, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Voltar para o Tinder", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor]
        return gradient
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextField.delegate = self
        setupView()
        setupHierarchy()
        setupConstraints()
        createObservers()
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardDidShow(notification: NSNotification){
        if let kbSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if let animationTime = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                UIView.animate(withDuration: animationTime){
                    
                    let bounds = UIScreen.main.bounds
                    
                    self.view.frame = CGRect(x: bounds.origin.x,
                                             y: bounds.origin.y,
                                             width: bounds.width,
                                             height: bounds.height - kbSize.height)
                    
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardDidHide(notification: NSNotification){
        if let animationTime = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            UIView.animate(withDuration: animationTime){
                self.view.frame = UIScreen.main.bounds
                self.view.layoutIfNeeded()
            }
        }
    }
    @objc func sendMessage(){
        if let message = self.messageTextField.text {
            
        }
    }
    
    func createObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.sendMessage()
        
        return true
    }
    
    func setupView(){
        view.backgroundColor = UIColor.blue
        messageLabel.textAlignment = .center
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.contentMode = .scaleAspectFit
        gradient.frame = self.view.frame
    }
    
    func setupHierarchy(){
        messageTextField.addSubview(messageSendButton)
        stackView.addArrangedSubview(likeImageView)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(messageTextField)
        stackView.addArrangedSubview(backButton)
        view.addSubview(pictureImageView)
        view.addSubview(stackView)
        pictureImageView.layer.addSublayer(gradient)
    }
    
    func setupConstraints(){
        pictureImageView.fillEntireView(view: view)
        stackView.fill(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, padding: .init(top: 0, left: 32, bottom: 46, right: 32))
        likeImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        messageTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        messageSendButton.fill(top: messageTextField.topAnchor, leading: nil, trailing: messageTextField.trailingAnchor, bottom: messageTextField.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
