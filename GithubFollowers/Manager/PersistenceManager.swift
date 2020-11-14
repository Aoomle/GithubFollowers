//
//  PersistenceManager.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 14/11/2020.
//

import Foundation

enum PersistenceActionType {
  case add, remove
}


enum PersistenceManager {
  
  static private let defaults = UserDefaults.standard
  
  
  enum Keys {
    static let favorites = "favorites"
  }
  
  
  static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (ErrorMessage?) -> Void){
    retriveFavorites { (result) in
      switch result {
      case.success(let favorites):
        var retrieveFavorite = favorites
        
        switch actionType {
        case .add:
          guard !retrieveFavorite.contains(favorite) else {
            completed(.alreadyInFavorites)
            return
          }
          retrieveFavorite.append(favorite)
          
        case .remove:
          retrieveFavorite.removeAll { $0.login == favorite.login }
        }
        
        completed(save(favorites: favorites))
        
      case.failure(let err):
        completed(err)
      }
    }
  }
  
  
  static func retriveFavorites(completed: @escaping (Result<[Follower], ErrorMessage>) -> Void) {
    guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
      completed(.success([]))
      return
    }
    
    do {
      let decorder = JSONDecoder()
      let favorites = try decorder.decode([Follower].self, from: favoritesData)
      completed(.success(favorites))
    }catch {
      completed(.failure(.unableToFavorite))
    }
  }
  
  
  static func save(favorites: [Follower]) -> ErrorMessage? {
    do {
      let encoder = JSONEncoder()
      let encoderFavorites = try encoder.encode(favorites)
      defaults.setValue(encoderFavorites, forKey: Keys.favorites)
      return nil
    } catch {
      return .unableToFavorite
    }
  }
}
