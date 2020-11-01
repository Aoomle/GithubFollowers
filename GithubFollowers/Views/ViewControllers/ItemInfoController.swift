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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureBackground()
    configureStackView()
    layoutUI()
  }
  
  fileprivate func configureBackground() {
    view.layer.cornerRadius = 18
    view.backgroundColor = .secondaryLabel
  }
  
  fileprivate func configureStackView() {
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing

    stackView.addArrangedSubview(itemInfoOne)
    stackView.addArrangedSubview(itemInfoTwo)
  }
  
  fileprivate func layoutUI() {
    view.addSubview(stackView)
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
