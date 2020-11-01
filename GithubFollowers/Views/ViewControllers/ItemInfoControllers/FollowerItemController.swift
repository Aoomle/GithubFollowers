//
//  ReposItemController.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 01/11/2020.
//

import UIKit

class FollowerItemController: ItemInfoController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }
  
  func configureItems() {
    itemInfoOne.set(itemInfoType: .followers, withCount: user.followers ?? 0)
    itemInfoTwo.set(itemInfoType: .following, withCount: user.following ?? 0)
    actionButton.set(title: "Get Followers" ,backgroundColor: .systemBackground, fontSize: 20)
  }
}
