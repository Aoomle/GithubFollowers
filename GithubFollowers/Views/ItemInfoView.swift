//
//  ItemInfoView.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 29/10/2020.
//

import UIKit

class ItemInfoView: UIView {
  
  let symbolImageView = UIImageView(image: SFSymbols.location.description, imageScale: .scaleAspectFill)
  let titleLabel = UILabel(textAligment: .left, fontSize: 14)
  let countLabel = UILabel(textAligment: .center, fontSize: 14)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUIElements()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  fileprivate func configureUIElements() {
    addSubview(symbolImageView)
    addSubview(titleLabel)
    addSubview(countLabel)
    
    NSLayoutConstraint.activate([
      symbolImageView.topAnchor.constraint(equalTo: topAnchor),
      symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      symbolImageView.widthAnchor.constraint(equalToConstant: 20),
      symbolImageView.heightAnchor.constraint(equalToConstant: 20),
      
      titleLabel.topAnchor.constraint(equalTo: symbolImageView.firstBaselineAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: 18),
      
      countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
      countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      countLabel.heightAnchor.constraint(equalToConstant: 18)
    ])
  }
  
  func set() {
    
  }
  
}


extension UIImageView {
  convenience init(image: String, imageScale: UIImageView.ContentMode) {
    self.init()
    self.image = UIImage(named: image)
    self.contentMode = imageScale
    translatesAutoresizingMaskIntoConstraints = false
  }
}
extension UILabel {
  convenience init(textAligment: NSTextAlignment, fontSize: CGFloat) {
    self.init()
    self.textAlignment = textAlignment
    self.font = .systemFont(ofSize: fontSize)
    translatesAutoresizingMaskIntoConstraints = false
  }
}
