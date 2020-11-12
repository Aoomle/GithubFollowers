//
//  ItemInfoController.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 01/11/2020.
//

import UIKit

class ItemInfoController: UIViewController {
  
  let stackView = UIStackView()
  let itemInfoOne = ItemInfoView()
  let itemInfoTwo = ItemInfoView()
  let actionButton = UIButton()
  
  var user: User!
  weak var delegate: UserInfoControllerDelegate!
  
  init(user: User) {
    super.init(nibName: nil, bundle: nil)
    self.user = user
  }
  
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureBackground()
    configureStackView()
    configureActionButton()
    layoutUI()
   
  }
  
  fileprivate func configureBackground() {
    view.layer.cornerRadius = 18
    view.backgroundColor = .secondarySystemBackground
    actionButton.translatesAutoresizingMaskIntoConstraints = false
  }
  
  fileprivate func configureStackView() {
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing

    stackView.addArrangedSubview(itemInfoOne)
    stackView.addArrangedSubview(itemInfoTwo)
  }
  
  fileprivate func configureActionButton() {
    actionButton.addTarget(self, action: #selector(handleTapped), for: .touchUpInside)
  }
  
  @objc func handleTapped() {
    
  }
  
  fileprivate func layoutUI() {
    view.addSubview(stackView)
    view.addSubview(actionButton)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    let padding: CGFloat = 20
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      stackView.heightAnchor.constraint(equalToConstant: 50),
      
      actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
      actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      actionButton.heightAnchor.constraint(equalToConstant: 44)
    ])
    
  }
}
