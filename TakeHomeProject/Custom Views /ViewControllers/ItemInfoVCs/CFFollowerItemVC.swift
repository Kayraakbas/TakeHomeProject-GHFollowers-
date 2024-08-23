//
//  CFFollowerItemVC.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 22.09.2024.
//

import UIKit


class CFFollowerItemVC: CFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    func configureItems() {
        itemInfoView1.set(itemInfoType: .followers, count: user.followers)
        itemInfoView2.set(itemInfoType: .following, count: user.following)
        actionButon.set(backgroundColor: .systemGreen, title: "Followers")
    }
}
