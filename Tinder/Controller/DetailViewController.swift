//
//  DetailViewController.swift
//  Tinder
//
//  Created by Alexandre  Machado on 11/07/23.
//

import UIKit

class HeaderLayout: UICollectionViewFlowLayout{
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ (attribute) in
            if attribute.representedElementKind == UICollectionView.elementKindSectionHeader {
                guard let collectionView = collectionView else {return}
                
                let contentOffsetY = collectionView.contentOffset.y
                
                attribute.frame = CGRect(x: 0,
                                         y: contentOffsetY,
                                         width: collectionView.bounds.width,
                                         height: attribute.bounds.height - contentOffsetY)
            }
        })
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}


class DetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var user: User? {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var callback: ((User?, Action) -> Void)?
    
    
    let cellId = "cellId"
    let headerId = "headerId"
    let profileId = "profileId"
    let photosId = "photosId"
    
    var deslikeButton: UIButton = .iconFooter(named: "icone-deslike")
    var likeButton: UIButton = .iconFooter(named: "icone-like")
    
    var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icone-down"), for: .normal)
        button.backgroundColor = UIColor(red: 232/255, green: 88/255, blue: 54/255, alpha: 1)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .equalCentering
        sv.spacing = 16
        return sv
    }()
    
    init() {
        super.init(collectionViewLayout: HeaderLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupConstraints()
    }
    
    func setupView(){
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 124, right: 0)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(DetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:headerId)
        collectionView.register(DetailProfileCollectionViewCell.self, forCellWithReuseIdentifier: profileId)
        collectionView.register(DetailPhotosCell.self, forCellWithReuseIdentifier: photosId)
        
        deslikeButton.addTarget(self, action: #selector(deslike), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(like), for: .touchUpInside)
        
    }
    
    func setupHierarchy(){
        view.addSubview(backButton)
        stackView.addArrangedSubviews([UIView(), deslikeButton, likeButton, UIView()])
        view.addSubview(stackView)
    }
    
    func setupConstraints(){
        stackView.fill(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, padding: .init(top: 0, left: 16, bottom: 34, right: 16))
        backButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 184).isActive = true
        backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileId, for: indexPath) as! DetailProfileCollectionViewCell
        cell.user = self.user
        return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photosId, for: indexPath) as! DetailPhotosCell
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        var height: CGFloat = UIScreen.main.bounds.width * 0.66
        
        if indexPath.item == 0 {
            let cell = DetailProfileCollectionViewCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
            cell.user = self.user
            cell.layoutIfNeeded()
            
            let estimateSize = cell.systemLayoutSizeFitting(CGSize(width: width, height: 1000))
            height = estimateSize.height
        }
        
        return .init(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! DetailHeaderView
        header.user = self.user
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.bounds.width, height: view.bounds.height * 0.7)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let originY = view.bounds.height * 0.7 - 24
        
        if scrollView.contentOffset.y > 0 {
            self.backButton.frame.origin.y = originY - scrollView.contentOffset.y
        } else {
            self.backButton.frame.origin.y = originY + scrollView.contentOffset.y * -1
        }
        
        
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func deslike() {
        self.callback?(self.user, Action.deslike)
        back()
    }
    
    @objc func like(){
        self.callback?(self.user, Action.like)
        back()
    }
}
