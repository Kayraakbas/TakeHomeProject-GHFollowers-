//
//  CFRepoItem.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 22.09.2024.
//

import UIKit


class CFRepoItem: CFItemInfoVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoView1.set(itemInfoType: .repos, count: user.publicRepos)
        itemInfoView2.set(itemInfoType: .gists, count: user.publicGists)
        actionButon.set(backgroundColor: .systemPurple, title: "Git-Hub Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}
