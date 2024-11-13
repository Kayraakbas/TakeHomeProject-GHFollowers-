//
//  CFTextField.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 23.08.2024.
//

import UIKit

class CFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 12
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        keyboardType = .default
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .go
        clearButtonMode = .whileEditing
        
        placeholder = "Enter a username"
    }
    
}
