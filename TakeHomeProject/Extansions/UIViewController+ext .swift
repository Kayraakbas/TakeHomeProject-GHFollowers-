//
//  UIViewController+ext .swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 26.08.2024.
//

import UIKit

extension UIViewController{
    
    func presentCFAlertOnMainThread (title : String , massage : String, buttonTitle : String){
        
        DispatchQueue.main.async {
            let alertVC = CFAlertVC(title: title, message: massage, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
