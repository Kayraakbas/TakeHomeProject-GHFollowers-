//
//  CFBodyLabel.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 26.08.2024.
//

import UIKit

class CFBodyLabel: UILabel {

    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment : NSTextAlignment){
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    private func configure(){
        
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
