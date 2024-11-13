//
//  CFAvatarImageView.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 28.08.2024.
//

import UIKit

class CFAvatarImageView: UIImageView {
    
    let placeHolderImage = UIImage(named: "avatar-placeholder")
    let chace = NetworkManager.shared.chace

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
