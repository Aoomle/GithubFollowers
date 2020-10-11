//
//  DownloadImage.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 11/10/2020.
//

import UIKit

extension UIImageView {
  
  /// Download an image from internet
  /// - Parameter imageUrl: imageUrl takes an url link of an image and convert it back to image
  func downloadImage(from imageUrl: String) {
    let cache = NetworkManager.shared.cacheImage
    let cacheKey = NSString(string: imageUrl)
    
    if let imageFromCache = cache.object(forKey: cacheKey) {
      self.image = imageFromCache
      return
    }
    
    guard let imageUrl = URL(string: imageUrl) else { return }

    URLSession.shared.dataTask(with: imageUrl) { [weak self] url, response, errror in
      guard let self = self else { return }
      if let _ = errror { return }
      guard let _ = response, let data = url else { return }
      guard let imageBobo = UIImage(data: data) else { return }
      
      cache.setObject(imageBobo, forKey: cacheKey)
      
      DispatchQueue.main.async { self.image = imageBobo }
     
    }.resume()

  }
  
}

