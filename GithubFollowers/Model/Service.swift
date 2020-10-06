//
//  Service.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 06/10/2020.
//

import Foundation

class Service {
  
  static let shared = Service()
  
  private init(){}
  
  let baseURL = "https://api.github.com/users/"

  
  func getFollowers(username: String, completion: @escaping ([Follower]?, String?) -> Void ){
    
    guard let endPoint = URL(string: baseURL + "\(username)/followers") else {
      completion(nil, "Bad endpoint.")
      return
    }
    
    URLSession.shared.dataTask(with: endPoint) { (data, response, error) in
      
      if let _ = error  {
        completion(nil, "Bad Url....")
        
      }
      
      guard let _ = response else {
        completion(nil, "Error response from server. Please try again..")
        return
      }
      
      guard let data = data else {
        //completion(nil, "Error downloading from server")
        return
      }
      
      print("download successfully.")
      
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let followers = try decoder.decode([Follower].self, from: data)
        completion(followers, nil)
        print("parsed successfully....")
      }catch {
        print("error parsing json")
      }
      
    }.resume()
    
  }
  
}















