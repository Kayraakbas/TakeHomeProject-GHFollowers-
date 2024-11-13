//
//  FollowerListVC.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 24.08.2024.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class FollowerListVC: UIViewController {

    enum Section {case main}

    var page = 1
    var followers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Follower>!
    var hasMoreFollowers = true
    var filteredFollowers: [Follower] = []
    var isSearching = false
    
    var username: String!
    
    init (username : String){
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
        configureSearchController()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func getFollowers(username : String, page : Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(username: username, page: page) { [weak self](result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
                case.success(let followers):
                
                if followers.count < 100 { self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                
                if followers.isEmpty {
                    
                    let message = "User does not have any followers."
                    DispatchQueue.main.async{
                        self.showEmptyStateView(with: message, in: self.view)
                        return
                    }
                }
                
                self.updateData(on: followers)
                case .failure(let error):
                    self.presentCFAlertOnMainThread(title: "Ooops", massage: error.rawValue, buttonTitle: "Ok")
            }
            
        }
        
    }
    
    
    func configureCollectionView(){
            
        collectionView = UICollectionView(frame: view.bounds , collectionViewLayout: UIHelper.createThreeCollumnFloatLayout(in: view))
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
    }
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "search for username"
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.backgroundColor = .clear
        navigationItem.searchController = searchController
        
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: {(collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
            
        })
    }
    func updateData(on followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    @objc func addButtonTapped(){
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    
                    guard let error = error else {
                        self.presentCFAlertOnMainThread(title: "Success", massage: "User successfully added to favorites", buttonTitle: "Ok")
                        return
                    }
                    
                    self.presentCFAlertOnMainThread(title: "Something went wrong", massage: error.rawValue, buttonTitle: "Ok")

                }
                
            case .failure(let  error):
                self.presentCFAlertOnMainThread(title: "Something went wrong", massage: error.rawValue, buttonTitle: "Ok")
                
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        
        present(navController, animated: true)
        
    }
}

extension FollowerListVC: UICollectionViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else {
                print ("no more page ")
                return
            }
            page += 1
            getFollowers(username: username , page: page)
        }
    }
    
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
        
    }
}

extension FollowerListVC: FollowerListVCDelegate{
    
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
}
