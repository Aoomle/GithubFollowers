//
//  FollowerListController.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 05/10/2020.
//

import UIKit

class FollowerListController: UICollectionViewController {
  
//  let cache = NSCache<String, UIImage>()
  
  var username: String?
  
  var follower = [Follower]()
  
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
    
    NetworkManager.shared.getFollowers(username: username ?? "aoomle") { (newfollowers, error) in
      
      guard let newfollowers = newfollowers else {
        DispatchQueue.main.async {
          let alertView = CustomAlertController(title: "Error", message: error!)
          alertView.modalPresentationStyle = .overFullScreen
          alertView.modalTransitionStyle = .crossDissolve
          self.present(alertView, animated: true, completion: nil)
        }
        return
      }

      DispatchQueue.main.async {
        self.follower.append(contentsOf: newfollowers)
        self.collectionView.reloadData()
      }
    }
    
  }
  
  @objc fileprivate func handleAdd() {
    print(#function)
  }
  
}


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
    
    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

    let numberofItem: CGFloat = 3

    let collectionViewWidth = self.collectionView.bounds.width

    let extraSpace = (numberofItem - 1) * flowLayout.minimumInteritemSpacing

    let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left

    let width = Int((collectionViewWidth - extraSpace - inset) / numberofItem)
    
    return CGSize(width: width, height: width)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 30
  }
  
}
