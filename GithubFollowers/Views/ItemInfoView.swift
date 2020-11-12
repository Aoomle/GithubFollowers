//
//  ItemInfoView.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 29/10/2020.
//

import UIKit

enum ItemInfoType {
  case repos, gists, followers, following
}


class ItemInfoView: UIView {
  
  let symbolImageView = UIImageView()
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
    
    symbolImageView.translatesAutoresizingMaskIntoConstraints = false
    symbolImageView.contentMode = .scaleAspectFit
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    countLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
      symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      symbolImageView.widthAnchor.constraint(equalToConstant: 20),
      symbolImageView.heightAnchor.constraint(equalToConstant: 20),
      
      titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: 18),
      
      countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
      countLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
      countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      countLabel.heightAnchor.constraint(equalToConstant: 18)
    ])
  }
  
  func set(itemInfoType: ItemInfoType, withCount count: Int) {
    switch itemInfoType {
    case .repos:
      symbolImageView.image = UIImage(systemName: SFSymbols.repos)
      titleLabel.text = "Public Repos"
      break
    case .gists:
      symbolImageView.image = UIImage(systemName: SFSymbols.gists)
      titleLabel.text = "Public Gists"
      break
    case .followers:
      symbolImageView.image = UIImage(systemName: SFSymbols.followers)
      titleLabel.text = "Followers"
      break
    case .following:
      symbolImageView.image = UIImage(systemName: SFSymbols.following)
      titleLabel.text = "Following"
      break
    }
    countLabel.text = String(count)
  }
  
}

extension UIImageView {
  convenience init(imageScale: UIImageView.ContentMode) {
    self.init()
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
