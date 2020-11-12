//
//  DateFormatter.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 08/11/2020.
//

import Foundation

extension String {
  func convertToDate() -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.date(from: self)
  }
  
  func displayDate() -> String {
    guard let date = self.convertToDate() else { return "N/A"}
    return date.convertDateToString()
  }
}


extension Date {
  func convertDateToString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM yyyy"
    return formatter.string(from: self)
  }
}
