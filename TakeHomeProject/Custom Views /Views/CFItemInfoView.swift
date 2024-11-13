//
//  CFItemInfoView.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 21.09.2024.
//

import UIKit


enum itemInfoType {
    case repos,gists,followers,following
}

class CFItemInfoView: UIView {
    
    let symbolImageIView = UIImageView()
    let titleLabel = CFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = CFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
     private func configure() {
        
         addSubview(symbolImageIView)
         addSubview(titleLabel)
         addSubview(countLabel)
         
         symbolImageIView.translatesAutoresizingMaskIntoConstraints = false
         symbolImageIView.contentMode = .scaleAspectFit
         symbolImageIView.tintColor = .label
         
         
         NSLayoutConstraint.activate([
            
            symbolImageIView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageIView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageIView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageIView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageIView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageIView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageIView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
            
            
         ])
         
     }
    
    func set(itemInfoType : itemInfoType, count : Int){
        
        switch itemInfoType {
        case .repos:
            symbolImageIView.image = UIImage(systemName: "folder")
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageIView.image = UIImage(systemName: "text.alignleft")
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageIView.image = UIImage(systemName: "heart")
            titleLabel.text = "Followers"
        case .following:
            symbolImageIView.image = UIImage(systemName: "person.2.fill")
            titleLabel.text = "Following"
        }
        countLabel.text = String(count) 
    }
    

}
