//
//  CFItemInfoVC.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 22.09.2024.
//

import UIKit

class CFItemInfoVC: UIViewController {

    let stackView = UIStackView()
    let itemInfoView1 = CFItemInfoView()
    let itemInfoView2 = CFItemInfoView()
    
    let actionButon = CFButton()
    
    weak var delegate: UserInfoVCDelegate!
    var user : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureActionButton()
        setupUI()
        setupStackView()

    }
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackgroundView(){
        
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
        
    }
    
    
    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoView1)
        stackView.addArrangedSubview(itemInfoView2)
        
    }
    
    
    private func configureActionButton() {
        actionButon.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() {}
    
    private func setupUI() {
        view.addSubview(stackView)
        view.addSubview(actionButon)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButon.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButon.heightAnchor.constraint(equalToConstant: 44),
            
            
        ])
        
    }
    

    

}
