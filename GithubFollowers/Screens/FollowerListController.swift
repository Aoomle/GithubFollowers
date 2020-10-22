//
//  FollowerListController.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 05/10/2020.
//

import UIKit

class FollowerListController: UICollectionViewController {
  
  var username: String?
  
  var follower = [Follower]()
  
  var page = 1
  
  var hasMoreFollowers = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    
    title = username ?? "aoomle"
    
    ///fix navigation back button animated while going back to the main tab controller
    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationController?.navigationBar.prefersLargeTitles = true
    setupCollectionView()

  }
  
  fileprivate func setupCollectionView() {
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: "collectionCell")
    collectionView.backgroundColor = .systemBackground
    collectionView.delegate = self
    
    let searchController = UISearchController(searchResultsController: nil)
    navigationItem.searchController = searchController
    searchController.delegate = self
    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = "Enter a username here"
    
    getFollowers(username: username ?? "aoomle", page: page)
    
  }
  
  
  fileprivate func getFollowers(username: String, page: Int) {
    showLoading()
    NetworkManager.shared.getFollowers(username: username , page: page) {[weak self] (newfollowers, error) in
      
      guard let self = self else { return }
      
      DispatchQueue.main.async { self.stopLoading()  }
      
      guard let newfollowers = newfollowers else {
        DispatchQueue.main.async {
          let alertView = CustomAlertController(title: "Error", message: error!)
          alertView.modalPresentationStyle = .overFullScreen
          alertView.modalTransitionStyle = .crossDissolve
          self.present(alertView, animated: true, completion: nil)
        }
        return
      }
      
      if newfollowers.count < 100 { self.hasMoreFollowers = false }
      DispatchQueue.main.async {
        self.follower.append(contentsOf: newfollowers)
        
        if newfollowers.isEmpty {
          self.showEmptyState(with: "This user doesn't have any followers. Go follow them", in: self.view)
        }
        self.collectionView.reloadData()
      }
     
    }
   
  }
  
  @objc fileprivate func handleAdd() {
    print(#function)
  }
  
}


// MARK:- Extensions
extension FollowerListController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return follower.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! FollowerCell
    cell.follower = follower[indexPath.row]
    return cell
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
}



extension FollowerListController: UISearchResultsUpdating, UISearchControllerDelegate {
  func updateSearchResults(for searchController: UISearchController) {
    print(searchController.searchBar.text)
  }
}
