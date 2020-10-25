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
  
  override func viewDidLoad() {
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDismiss))
    navigationItem.rightBarButtonItem = doneButton
    
    showLoading()
    NetworkManager.shared.getUser(username: username ?? "aoomle") { [weak self] (result) in
      guard let self = self else { return }
      
      switch result {
      case .success(let user):
        guard  let user = user else { return }
        DispatchQueue.main.async {
          self.add(childController: UserHeaderInfo(user: user), to: self.containView)
        }
        
      case .failure(let error):
        self.presentAlert(title: "User Ino", message: error.rawValue)
      }
      self.stopLoading()
    }
    configureContainerView()
  }
  
  @objc fileprivate func handleDismiss() {
    dismiss(animated: true)
  }
  
  func configureContainerView() {
    view.addSubview(containView)
    containView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      containView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      containView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      containView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      containView.heightAnchor.constraint(equalToConstant: 180),
    ])
  }
  
  func add(childController: UIViewController, to containerView: UIView) {
    addChild(childController)
    containerView.addSubview(childController.view)
    childController.view.frame = containerView.bounds
    childController.didMove(toParent: self)
  }
}
