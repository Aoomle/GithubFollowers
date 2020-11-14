//
//  FavoriteController.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 05/10/2020.
//

import UIKit

class FavoriteController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemIndigo
    navigationController?.setNavigationBarHidden(true, animated: true)
    
    PersistenceManager.retriveFavorites { result in
      
      switch result {
      case .success(let favorites):
        print(favorites)
      case .failure(let _):
        break
      }
    }
  }
  
}
