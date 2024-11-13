//
//  CFButton.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 23.08.2024.
//

import UIKit

class CFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (backgroundColor: UIColor , title: String){
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    private func configure (){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    
    
    func set(backgroundColor: UIColor, title: String){
        
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
