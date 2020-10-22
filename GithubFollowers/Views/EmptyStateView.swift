//
//  EmptyStateView.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 22/10/2020.
//

import UIKit


class EmptyStateView: UIView {
  
 fileprivate let imageView: UIImageView = {
    let img = UIImageView(image: #imageLiteral(resourceName: "empty-state-logo"))
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
 fileprivate let messageLabel: UILabel = {
    let message = UILabel()
    message.text = "This user doesn't have any follower"
    message.numberOfLines = 3
    message.textAlignment = .center
    message.font = .systemFont(ofSize: 28)
    message.textColor = .secondaryLabel
    message.translatesAutoresizingMaskIntoConstraints = false
    return message
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureView()
  }
  
  init(message: String) {
    super.init(frame: .zero)
    messageLabel.text = message
    configureView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func configureView() {
    addSubview(imageView)
    addSubview(messageLabel)
    
    NSLayoutConstraint.activate([
      messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -170),
      messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
      messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
      messageLabel.heightAnchor.constraint(equalToConstant: 200),
      
      imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
      imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40)
    ])
  }
  
}
