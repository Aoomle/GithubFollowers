//
//  Service.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 06/10/2020.
//

import UIKit

class NetworkManager {
  
  static let shared = NetworkManager()
  let cacheImage = NSCache<NSString, UIImage>()
  
  private init(){}
  
  private let baseURL = "https://api.github.com/"

  func getFollowers(username: String, page: Int, completion: @escaping ([Follower]?, String?) -> Void ){
    
    guard let endPoint = URL(string: baseURL + "users/\(username)/followers?per_page=100&page=\(page)") else {
      completion(nil, ErrorMessage.error.rawValue)
      return
    }
    
    URLSession.shared.dataTask(with: endPoint) { (data, response, error) in
      
      if let _ = error  {
        completion(nil, ErrorMessage.error.rawValue)
        return
      }
      
      guard let _ = response else {
        completion(nil, ErrorMessage.invalidResponse.rawValue)
        return
      }
      
      guard let data = data else {
        completion(nil, ErrorMessage.invalidData.rawValue)
        return
      }
      
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let followers = try decoder.decode([Follower].self, from: data)
        completion(followers, nil)
      } catch {
        completion(nil, ErrorMessage.invalidData.rawValue)
      }
      
    }.resume()
    
  }
  
  func getUser(username: String, completion: @escaping (Result<User?, ErrorMessage>) -> Void) {
    guard let endPoint = URL(string: baseURL + "users/\(username)") else {
      completion(.failure(.usename))
      return
    }
    
    URLSession.shared.dataTask(with: endPoint) { (data, response, error) in
      
      if let _ = error {
        completion(.failure(.error))
        return
      }
      
      guard let _ = response else {
        completion(.failure(.invalidResponse))
        return
      }
      
      guard let data = data else {
        completion(.failure(.invalidData))
        return
      }
      
      do {
        let decode = JSONDecoder()
        decode.keyDecodingStrategy = .convertFromSnakeCase
        decode.dateDecodingStrategy = .iso8601
        let user = try decode.decode(User.self, from: data)
        completion(.success(user))
      } catch {
        completion(.failure(.invalidData))
      }
      
    }.resume()
    
  }
  
}

