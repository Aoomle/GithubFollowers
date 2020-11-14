//
//  FavoritesCell.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 14/11/2020.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
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
      txt.textAlignment = .left
      txt.font = .systemFont(ofSize: 26)
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
    
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(avatarImage)
    addSubview(avatarTitle)
    
    accessoryType = .disclosureIndicator
    let padding: CGFloat = 12
    
    NSLayoutConstraint.activate([
      avatarImage.centerYAnchor.constraint(equalTo: centerYAnchor),
      avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      avatarImage.heightAnchor.constraint(equalToConstant: 60),
      avatarImage.widthAnchor.constraint(equalToConstant: 60),
      
      avatarTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
      avatarTitle.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 24),
      avatarTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      avatarTitle.heightAnchor.constraint(equalToConstant: 60),
      
    ])
    
  }
  
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
  
}
