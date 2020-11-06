//
//  ReposItemController.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 01/11/2020.
//

import UIKit

class ReposItemController: ItemInfoController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }
  
  func configureItems() {
    itemInfoOne.set(itemInfoType: .repos, withCount: user.publicRepos)
    itemInfoTwo.set(itemInfoType: .gists, withCount: user.publicGists)
    actionButton.set(title: "Github Profile" ,backgroundColor: .systemBackground, fontSize: 20)
  }
}
