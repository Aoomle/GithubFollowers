//
//  FavoriteController.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 05/10/2020.
//

import UIKit

class FavoriteController: UIViewController {
  
  var tableView = UITableView()
  var favorites = [Follower]()
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getFavorites()
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureTableView()
  }
  

  fileprivate func configureViewController() {
    view.backgroundColor = .systemBackground
    title = "Favorites"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  fileprivate func configureTableView() {
    view.addSubview(tableView)
    tableView.frame = view.bounds
    tableView.rowHeight = 80
    tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.resuseID)
    tableView.delegate = self
    tableView.dataSource = self
  }

  fileprivate func getFavorites() {
    PersistenceManager.retriveFavorites { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let favorites):
        if favorites.isEmpty {
          self.showEmptyState(with: "No Favorites?\nAdd one on the follower screen", in: self.view)
        } else {
          self.favorites = favorites
          DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
          }
        }
      
      case .failure(let error):
        self.presentAlert(title: "Something went wrong", message: error.rawValue)
      }
    }
  }
  
}


extension FavoriteController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favorites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.resuseID) as! FavoritesCell
    cell.follower = favorites[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let favorite = favorites[indexPath.row]
    let layout = UICollectionViewFlowLayout()
    let destVC = FollowerListController(collectionViewLayout: layout)
    destVC.username = favorite.login
    destVC.title = favorite.login
    navigationController?.pushViewController(destVC, animated: true)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    guard editingStyle == .delete else { return }
    let favorite = favorites[indexPath.row]
    favorites.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .left)
    
    PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
      guard let self = self else { return }
      guard let error = error else { return }
      self.presentAlert(title: "Unable to remove", message: error.rawValue)
    }
  }
}
