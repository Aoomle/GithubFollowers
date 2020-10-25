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
    view.addSubview(middleContainer)
    view.addSubview(bottomContainer)
    
    containView.translatesAutoresizingMaskIntoConstraints = false
    middleContainer.translatesAutoresizingMaskIntoConstraints = false
    bottomContainer.translatesAutoresizingMaskIntoConstraints = false
    
    middleContainer.backgroundColor = .systemTeal
    bottomContainer.backgroundColor = .systemGreen
    
    NSLayoutConstraint.activate([
      containView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      containView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      containView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      containView.heightAnchor.constraint(equalToConstant: 180),
      
      middleContainer.topAnchor.constraint(equalTo: containView.safeAreaLayoutGuide.bottomAnchor, constant: 20),
      middleContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      middleContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      middleContainer.heightAnchor.constraint(equalToConstant: 180),
      
      bottomContainer.topAnchor.constraint(equalTo: middleContainer.safeAreaLayoutGuide.bottomAnchor, constant: 20),
      bottomContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      bottomContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      bottomContainer.heightAnchor.constraint(equalToConstant: 180),
    ])
  }
  
  func add(childController: UIViewController, to containerView: UIView) {
    addChild(childController)
    containerView.addSubview(childController.view)
    childController.view.frame = containerView.bounds
    childController.didMove(toParent: self)
  }
}
