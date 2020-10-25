//
//  UserHeaderInfo.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 25/10/2020.
//

import UIKit

class UserHeaderInfo: UIViewController {
  
  let imageView: UIImageView = {
    let img = UIImageView()
    img.translatesAutoresizingMaskIntoConstraints = false
    img.layer.cornerRadius = 5
    img.clipsToBounds = true
    return img
  }()
  
  let usernameLabel: UILabel = {
    let username = UILabel()
    username.translatesAutoresizingMaskIntoConstraints = false
    username.text = "Aoomle"
    username.font = .preferredFont(forTextStyle: .title1)
    return username
  }()
  
  let nameLabel: UILabel = {
    let name = UILabel()
    name.translatesAutoresizingMaskIntoConstraints = false
    name.text = "Abdulmalik Muhammad"
    name.font = .preferredFont(forTextStyle: .subheadline)
    return name
  }()
  
  let imageLocation: UIImageView = {
    let img = UIImageView()
    img.translatesAutoresizingMaskIntoConstraints = false
    img.image = UIImage(systemName: "mappin.and.ellipse")
    img.tintColor = .secondaryLabel
    return img
  }()
  
  let locationLabel: UILabel = {
    let lct = UILabel()
    lct.translatesAutoresizingMaskIntoConstraints = false
    lct.text = "Abuja"
    return lct
  }()
  
  let bioLabel: UILabel = {
    let bio = UILabel()
    bio.translatesAutoresizingMaskIntoConstraints = false
    bio.text = "I am super awesome. I can code without talking too much. Okay everthing is fun"
    bio.textAlignment = .left
    bio.adjustsFontSizeToFitWidth = true
    bio.minimumScaleFactor = 0.75
    bio.numberOfLines = 3
    bio.lineBreakMode = .byTruncatingTail
    return bio
  }()
  
  let padding: CGFloat = 20
  
  var user: User!
  
  init(user: User) {
    super.init(nibName: nil, bundle: nil)
    self.user = user
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureUIElements()
    configureUIElementsData()
  }
  
  
  func configureUIElementsData() {
    imageView.downloadImage(from: user.avatarUrl)
    usernameLabel.text = user.login
    nameLabel.text = user.name
    locationLabel.text = user.location
    bioLabel.text = user.bio
  }
  
  func configureUIElements() {
    addSubviews()
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      imageView.widthAnchor.constraint(equalToConstant: 90),
      imageView.heightAnchor.constraint(equalToConstant: 90),
      
      usernameLabel.topAnchor.constraint(equalTo: imageView.firstBaselineAnchor),
      usernameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
      usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding),
      usernameLabel.heightAnchor.constraint(equalToConstant: 30),
      
      nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
      nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
      nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding),
      nameLabel.heightAnchor.constraint(equalToConstant: 20),
      
      imageLocation.bottomAnchor.constraint(equalTo: imageView.lastBaselineAnchor),
      imageLocation.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
      imageLocation.widthAnchor.constraint(equalToConstant: 20),
      imageLocation.heightAnchor.constraint(equalToConstant: 20),
      
      locationLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
      locationLabel.leadingAnchor.constraint(equalTo: imageLocation.trailingAnchor, constant: 12),
      locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding),
      locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
      bioLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
      bioLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
      bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      bioLabel.heightAnchor.constraint(equalToConstant: 60)
      
    ])
  }
  
  
  func addSubviews() {
    view.addSubview(imageView)
    view.addSubview(usernameLabel)
    view.addSubview(nameLabel)
    view.addSubview(imageLocation)
    view.addSubview(locationLabel)
    view.addSubview(bioLabel)
  }
}

