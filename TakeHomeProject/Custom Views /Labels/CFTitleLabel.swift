//
//  CFTitleLabel.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 26.08.2024.
//

import UIKit

class CFTitleLabel: UILabel {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init (textAlignment: NSTextAlignment, fontSize : CGFloat){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()

        
    }
    
    private func configure(){
        textColor = .label
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
