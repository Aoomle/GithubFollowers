//
//  FollowerListController.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 05/10/2020.
//

import UIKit

protocol FollowerListControllerDelegate: class {
  func didRequestFollowers(for username: String)
}

class FollowerListController: UICollectionViewController {
  
  enum Section { case main }
  
  var username: String?
  var followers = [Follower]()
  var filterFollowers = [Follower]()
  var page = 1
  var hasMoreFollowers = true
  var isSearching = false
  
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewController()
    setupCollectionView()
    setupSearchController()
    getFollowers(username: username ?? "aoomle", page: page)
    configureDataSource()
  }
  
  fileprivate func setupViewController() {
    title = username ?? "aoomle"
    ///fix navigation back button animated while going back to the main tab controller
    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
  }
 
  fileprivate func setupCollectionView() {
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.resuseID)
    collectionView.backgroundColor = .systemBackground
    collectionView.delegate = self
  }
  
  fileprivate func setupSearchController() {
    let searchController = UISearchController()
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = "Enter a username"
    navigationItem.searchController = searchController
  }
  
  func getFollowers(username: String, page: Int) {
    showLoading()
    NetworkManager.shared.getFollowers(username: username , page: page) {[weak self] (followers, error) in
      guard let self = self else { return }
      
      DispatchQueue.main.async { self.stopLoading()  }
      guard let followers = followers else { self.presentAlert(title: "Error", message: error!)
        return }
      
      if followers.count < 100 { self.hasMoreFollowers = false }
      self.followers.append(contentsOf: followers)
        
      if self.followers.isEmpty {
        let message = "This user doesn't have any followers. Go follow them"
        DispatchQueue.main.async { self.showEmptyState(with: message, in: self.view) }
        return
      }
        self.updateData(on: self.followers)
    }
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView,
                                                                       cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.resuseID,
                                                    for: indexPath) as! FollowerCell
      cell.follower = follower
      return cell
    })
  }
  
  func updateData(on followers: [Follower]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapshot.appendSections([.main])
    snapshot.appendItems(followers)
    DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
  }
  
  @objc fileprivate func handleAdd() {
    print(#function)
  }
  
}


extension FollowerListController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: createLayoutGrid(in: collectionView, collectionViewLayout: collectionViewLayout as! UICollectionViewFlowLayout), height: createLayoutGrid(in: collectionView, collectionViewLayout: collectionViewLayout as! UICollectionViewFlowLayout))
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 35
  }
  
}


// MARK:- Scroll view
extension FollowerListController {
  override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.height

    if offsetY > contentHeight - height {
      guard hasMoreFollowers else { return }
      page += 1
      getFollowers(username: username ?? "aoomle", page: page)
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let activeFollower = isSearching ? filterFollowers : followers
    let followers = activeFollower[indexPath.item]
    let destController = UserInfoController()
    destController.username = followers.login
    destController.delegate = self
    let destUserInfoController = UINavigationController(rootViewController: destController)
    present(destUserInfoController, animated: true)
  }
}


extension FollowerListController: UISearchResultsUpdating, UISearchBarDelegate {
  func updateSearchResults(for searchController: UISearchController) {
    guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
    isSearching = true
    filterFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
    updateData(on: filterFollowers)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    isSearching = false
    updateData(on: followers)
  }

}

extension FollowerListController: FollowerListControllerDelegate {
  func didRequestFollowers(for username: String) {
    self.username = username
    self.title = username
    self.page = 1
    followers.removeAll()
    filterFollowers.removeAll()
    collectionView.setContentOffset(.zero, animated: true)
    getFollowers(username: username, page: page)
  }
}
