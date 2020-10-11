//
//  SearchController.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 05/10/2020.
//

import UIKit

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
      logoImageView.heightAnchor.constraint(equalToConstant: 220),
      
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
    guard isUsernameEmpty else {
      view.endEditing(true)
      popAlertView()
      return false
    }
    pushViewController()
  
    return true
  }
  
  @objc fileprivate func handleFollowers() {
    guard isUsernameEmpty else {
        popAlertView()
      return
    }
      pushViewController()
  }
  
  fileprivate func pushViewController() {
    let layout = UICollectionViewFlowLayout()
    let followerList = FollowerListController(collectionViewLayout: layout)
    followerList.username = usernameLabel.text
    navigationController?.pushViewController(followerList, animated: false)
  }
  
  fileprivate func popAlertView() {
    let alertView = CustomAlertController(title: "Username required", message: "Username can't be empty, Please enter your username.")
    alertView.modalPresentationStyle = .overFullScreen
    alertView.modalTransitionStyle = .crossDissolve
    alertView.title = "Water porblem"
    present(alertView, animated: true, completion: nil)
  }
}
