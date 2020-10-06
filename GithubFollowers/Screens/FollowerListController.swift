//
//  FollowerListController.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 05/10/2020.
//

import UIKit

class FollowerListController: UIViewController {
  
  var username: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    
    title = username ?? "Follower list"
    ///fix navigation back button animated while going back to the main tab controller
    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationController?.navigationBar.prefersLargeTitles = true
    print(username ?? "no username passed")
    print(123456)
  }
  
  
  @objc fileprivate func handleAdd() {
    print(#function)
  }
}
