//
//  ViewController.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 03/10/2020.
//

import UIKit

class MainTabController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
 
    tabBar.tintColor = .label
    setupUI()
    view.backgroundColor = .systemBackground
    navigationController?.setNavigationBarHidden(false, animated: false)
  }
  
  fileprivate func setupUI() {
    viewControllers = [
      generateController(viewController: SearchController(), tabIcon: .search),
      generateController(viewController: FavoriteController(), tabIcon: .favorites)
    ]
  }

  fileprivate func generateController(viewController: UIViewController, tabIcon: UITabBarItem.SystemItem) -> UINavigationController {
    let view = UINavigationController(rootViewController: viewController)
    view.tabBarItem = UITabBarItem(tabBarSystemItem: tabIcon, tag: 0)
    view.navigationBar.tintColor = .label
    return view
  }

}

//MARK:- Search Controller
class SearchController: UIViewController, UITextFieldDelegate {
  
  let usernameLabel: UITextField = {
    var username = UITextField()
    username.placeholder = "Enter a username"
    username.layer.cornerRadius = 10
    username.layer.borderWidth = 2
    username.layer.borderColor = UIColor.systemGray3.cgColor
    username.textAlignment = .center
    
    username.keyboardAppearance = .alert
    username.returnKeyType = .search
    username.autocorrectionType = .no
    username.minimumFontSize = 12
    username.adjustsFontSizeToFitWidth = true
    username.translatesAutoresizingMaskIntoConstraints = false
    return username
  }()
  
  //closure
  let sendbutton: UIButton = {
    var sendbt = UIButton()
    sendbt.setTitle("Get Followers", for: .normal)
    sendbt.titleLabel?.font = .systemFont(ofSize: 20)
    sendbt.backgroundColor = .label
    sendbt.setTitleColor(.systemBackground, for: .normal)
    sendbt.layer.cornerRadius = 10
    sendbt.translatesAutoresizingMaskIntoConstraints = false
    return sendbt
  }()
  
  let logoImageView: UIImageView = {
    var liv = UIImageView(image: #imageLiteral(resourceName: "gh-logo"))
    liv.translatesAutoresizingMaskIntoConstraints = false
    return liv
  }()
  
  //computed propety
  var isUsernameEmpty: Bool { !usernameLabel.text!.isEmpty }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    usernameLabel.delegate = self
    
    view.addSubview(usernameLabel)
    view.addSubview(sendbutton)
    view.addSubview(logoImageView)
    
    sendbutton.addTarget(self, action: #selector(handleFollowers), for: .touchUpInside)
    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.widthAnchor.constraint(equalToConstant: 220),
      logoImageView.heightAnchor.constraint(equalToConstant: 200),
      
      usernameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      usernameLabel.heightAnchor.constraint(equalToConstant: 50),
      
      sendbutton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      sendbutton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      sendbutton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      sendbutton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    pushViewController()
    view.endEditing(true)
    return true
  }
  
  @objc fileprivate func handleFollowers() {
    print(#function)
    pushViewController()
  }
  
  fileprivate func pushViewController() {
    let followerList = FollowerListController()
    followerList.username = usernameLabel.text
    navigationController?.pushViewController(followerList, animated: false)
  }
}

//MARK:- Favorite Controller
class FavoriteController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemIndigo
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
}

//MARK:- Follower List Controller
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
