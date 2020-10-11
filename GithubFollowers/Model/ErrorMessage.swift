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
  case response   = "Invalid response from server. Please try again."
  case data       = "The data received from the server is invalid, Please try again."
}
