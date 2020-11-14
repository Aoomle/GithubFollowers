//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 07/10/2020.
//

import Foundation

enum ErrorMessage: String, Error {
  case usename    = "This username created was invalid. Please try again. "
  case error      = "Unable to complete your request. Please check your internet connection."
  case invalidResponse   = "Invalid response from server. Please try again."
  case invalidData       = "The data received from the server is invalid, Please try again."
  case unableToFavorite = "There was an erro favoriting this user. Please try again!"
  case alreadyInFavorites = "You've already favorited this user. You must REALLY like them!"
}
