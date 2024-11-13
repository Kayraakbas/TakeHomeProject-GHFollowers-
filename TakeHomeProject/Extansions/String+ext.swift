//
//  String+ext.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 22.09.2024.
//

import Foundation


extension String {
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A"}
        return date.convertToMonthYear()
    }
}
