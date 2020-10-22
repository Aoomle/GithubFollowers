//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 08/10/2020.
//

import UIKit

class FollowerCell: UICollectionViewCell {
  
  static let resuseID = "cellID"
  
  let imageCache = NSCache<NSString, UIImage>()
  
  var avatarImage: UIImageView = {
    var iv = UIImageView(image: #imageLiteral(resourceName: "avatar-placeholder"))
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.layer.cornerRadius = 10
    iv.clipsToBounds = true
    return iv
  }()
  
  var avatarTitle: UILabel = {
    var txt = UILabel()
    txt.text = ""
    txt.translatesAutoresizingMaskIntoConstraints = false
    txt.textAlignment = .center
    txt.adjustsFontSizeToFitWidth = true
    return txt
  }()
  
  var follower: Follower? {
    didSet {
      avatarTitle.text = follower?.login
      avatarImage.downloadImage(from: follower?.avatarUrl ?? "")
      avatarImage.contentMode = .scaleAspectFit
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let stackView = UIStackView(arrangedSubviews: [avatarImage, avatarTitle])
    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .fill
    stackView.axis = .vertical
    stackView.spacing = 0
       
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      stackView.heightAnchor.constraint(equalToConstant: 140),
 
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

