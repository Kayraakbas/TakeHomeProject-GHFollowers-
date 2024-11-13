//
//  UserInfoVC.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 19.09.2024.
//

import UIKit


protocol UserInfoVCDelegate: AnyObject {
    
    func didTapGithubProfile(for user: User)
    func didtapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {

    let headerView = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    var itemsView: [UIView] = []
    let dateLabel = CFBodyLabel(textAlignment: .center)
    
    var username: String!
    weak var delegate : FollowerListVCDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUser()
    }
    
    @objc func DismissVC(){
        dismiss(animated: true)
        
    }
    
    func layoutUI(){
        
        itemsView = [headerView, itemView1, itemView2, dateLabel]
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 180
        
        
        for item in itemsView{
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                
                item.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
                item.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            ])
        }
      
        
        headerView.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            itemView1.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemView2.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: 30),
            itemView2.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemView2.bottomAnchor, constant: 30),
            dateLabel.heightAnchor.constraint(equalToConstant: 30)
            
            
        ])
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(DismissVC))
        navigationItem.leftBarButtonItem = doneButton
    }
    
    func getUser(){
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
                
            case .failure(let error):
                presentCFAlertOnMainThread(title: "Ooops!", massage: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    
    func configureUIElements(with user: User){
        self.add(childVC: CFUserInfoHeaderVC(user: user), to: self.headerView)
        
        let repoItemVC = CFRepoItem(user: user)
        repoItemVC.delegate = self
        
        let followersItemVC = CFFollowerItemVC(user: user)
        followersItemVC.delegate = self
        
        self.add(childVC: repoItemVC, to: self.itemView1)
        self.add(childVC: followersItemVC, to: self.itemView2)
        self.dateLabel.text =  "GitHub since: \(user.createdAt.convertToMonthYear())"
    }
     
    func add(childVC: UIViewController, to parent: UIView) {
        addChild(childVC)
        parent.addSubview(childVC.view)
        childVC.view.frame = parent.bounds
        childVC.didMove(toParent: self)
        
    }
    

}


extension UserInfoVC: UserInfoVCDelegate{
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentCFAlertOnMainThread(title: "Invalid URL", massage: "This user does not have a github profile", buttonTitle: "Ok")
            return
        }
        presentSafari(url: url)
    }
    
    func didtapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentCFAlertOnMainThread(title: "No Followers", massage: "this user does not have any followers", buttonTitle: "Ok")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        DismissVC()
    }

}
