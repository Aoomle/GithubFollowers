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
    
    title = username ?? "aoomle"
    
    Service.shared.getFollowers(username: username ?? "aoomle") { (followers, error) in
      guard let followers = followers else {
        
        DispatchQueue.main.async {
          let alertView = CustomAlertController(title: "Error", message: error ?? "")
          alertView.modalPresentationStyle = .overFullScreen
          alertView.modalTransitionStyle = .crossDissolve
          self.present(alertView, animated: true, completion: nil)
        }
       
        return
      }
      
      followers.forEach { (item) in
        print(item)
      }
    }
    ///fix navigation back button animated while going back to the main tab controller
    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationController?.navigationBar.prefersLargeTitles = true
    
  }
  
  
  @objc fileprivate func handleAdd() {
    print(#function)
  }
}
