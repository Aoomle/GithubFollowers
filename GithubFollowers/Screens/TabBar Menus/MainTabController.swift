//
//  ViewController.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 03/10/2020.
//

import UIKit

class MainTabController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
 
    tabBar.tintColor = .label
    setupUI()
    view.backgroundColor = .systemBackground
    navigationController?.setNavigationBarHidden(false, animated: false)
  }
  
  fileprivate func setupUI() {
    viewControllers = [
      generateController(viewController: SearchController(), tabIcon: .search),
      generateController(viewController: FavoriteController(), tabIcon: .favorites)
    ]
  }

  fileprivate func generateController(viewController: UIViewController, tabIcon: UITabBarItem.SystemItem) -> UINavigationController {
    let view = UINavigationController(rootViewController: viewController)
    view.tabBarItem = UITabBarItem(tabBarSystemItem: tabIcon, tag: 0)
    view.navigationBar.tintColor = .label
    return view
  }

}

