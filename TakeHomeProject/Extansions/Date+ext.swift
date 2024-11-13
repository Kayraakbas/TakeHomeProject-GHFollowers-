//
//  Date+ext.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 22.09.2024.
//

import Foundation

extension Date {
    
    
    func convertToMonthYear() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}

