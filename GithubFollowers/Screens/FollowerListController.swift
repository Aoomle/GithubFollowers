//
//  FollowerListController.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 05/10/2020.
//

import UIKit

class FollowerListController: UICollectionViewController {
  
  enum Section {
    case main
  }
  
  var username: String?
  
  var follower = [Follower]()
  
  var page = 1
  
  var hasMoreFollowers = true
  
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
  
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
    
    getFollowers(username: username ?? "aoomle", page: page)
    configureDataSource()

  }
  
  
  fileprivate func getFollowers(username: String, page: Int) {
    NetworkManager.shared.getFollowers(username: username , page: page) { (newfollowers, error) in
      
      guard let newfollowers = newfollowers else {
        DispatchQueue.main.async {
          let alertView = CustomAlertController(title: "Error", message: error!)
          alertView.modalPresentationStyle = .overFullScreen
          alertView.modalTransitionStyle = .crossDissolve
          self.present(alertView, animated: true, completion: nil)
        }
        return
      }
      
      if newfollowers.count < 50 { self.hasMoreFollowers = false }
      DispatchQueue.main.async {
        self.follower.append(contentsOf: newfollowers)
        self.updateData()
      }
    }
  }
  
  @objc fileprivate func handleAdd() {
    print(#function)
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! FollowerCell
      cell.follower = follower
      return cell
    })
  }
  
  func updateData() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapshot.appendSections([.main])
    snapshot.appendItems(follower)
    DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
  }
}



extension FollowerListController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: threePhotoGrid(in: collectionView, collectionViewLayout: collectionViewLayout as! UICollectionViewFlowLayout), height: threePhotoGrid(in: collectionView, collectionViewLayout: collectionViewLayout as! UICollectionViewFlowLayout))
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
      updateData()
    }
  }
}
