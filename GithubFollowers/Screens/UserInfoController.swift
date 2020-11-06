//
//  UserInfoController.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 25/10/2020.
//

import UIKit

class UserInfoController: UIViewController {

  var username: String?

  let containView = UIView()
  let middleContainer = UIView()
  let bottomContainer = UIView()
  
  var arrayOfViews = [UIView]()
  
  override func viewDidLoad() {
    configureViewController()
    configureContainerView()
    getUserInfo()
  }
  
 fileprivate func getUserInfo() {
    showLoading()
    NetworkManager.shared.getUser(username: username ?? "aoomle") { [weak self] (result) in
      guard let self = self else { return }
      
      switch result {
      case .success(let user):
        guard  let user = user else { return }
        DispatchQueue.main.async {
          self.add(childController: UserHeaderInfo(user: user), to: self.containView)
          self.add(childController: ReposItemController(user: user), to: self.middleContainer)
          self.add(childController: FollowerItemController(user: user), to: self.bottomContainer)
        }
      case .failure(let error):
        self.presentAlert(title: "User Ino", message: error.rawValue)
      }
      self.stopLoading()
    }
  }
  
  fileprivate func configureViewController() {
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDismiss))
    navigationItem.rightBarButtonItem = doneButton
  }
  
  @objc fileprivate func handleDismiss() {
    dismiss(animated: true)
  }
  
  func configureContainerView() {
    let padding: CGFloat = 20
    let itemHeight: CGFloat = 160
    
    arrayOfViews = [containView, middleContainer, bottomContainer]
    for itemViews in arrayOfViews {
      view.addSubview(itemViews)
      itemViews.translatesAutoresizingMaskIntoConstraints = false
      itemViews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
      itemViews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
      
    }
    
    NSLayoutConstraint.activate([
      containView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
      containView.heightAnchor.constraint(equalToConstant: itemHeight),
      
      middleContainer.topAnchor.constraint(equalTo: containView.bottomAnchor, constant: padding),
      middleContainer.heightAnchor.constraint(equalToConstant: itemHeight),
      
      bottomContainer.topAnchor.constraint(equalTo: middleContainer.bottomAnchor, constant: padding),
      bottomContainer.heightAnchor.constraint(equalToConstant: itemHeight),
    ])
  }
  
  func add(childController: UIViewController, to containerView: UIView) {
    addChild(childController)
    containerView.addSubview(childController.view)
    childController.view.frame = containerView.bounds
    childController.didMove(toParent: self)
  }
}
