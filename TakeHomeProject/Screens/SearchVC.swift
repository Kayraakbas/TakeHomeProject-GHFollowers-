//
//  SearchVC.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 23.08.2024.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView = UIImageView()
    let usernameTextField = CFTextField()
    let callToActionButton = CFButton(backgroundColor: .systemGreen, title: "Get Followers")
    var logoImageViewTopConstraint : NSLayoutConstraint!
    
    var isUserNameEntered : Bool {return !usernameTextField.text!.isEmpty}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureActionButton()
        createDismissKeyboardTabGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    
    @objc func pushFollowersListVC(){
        
        guard isUserNameEntered else {
            presentCFAlertOnMainThread(title: "Empty Username", massage: "Please enter existing username.", buttonTitle: "Ok")
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        let followerListVC = FollowerListVC(username: usernameTextField.text!)
        followerListVC.username = usernameTextField.text
        followerListVC.title = usernameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true)
        
    }
    
    
    func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        let topConstraintConstant : CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 20 : 80
        
        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
        logoImageViewTopConstraint.isActive = true
       
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        
        ])
        
    }
    
    func configureTextField(){
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
    
    
        NSLayoutConstraint.activate([
        
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
          
        ])
        
    }
    
    
    func createDismissKeyboardTabGesture(){
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    func configureActionButton(){
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50),
        
        ])
        
    }
    
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("did tab returns")
        pushFollowersListVC()
        return true
    }
    
}
