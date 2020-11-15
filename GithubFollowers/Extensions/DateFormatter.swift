//
//  DateFormatter.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 08/11/2020.
//

import Foundation

extension Date {
  func convertToMonthYearFormat() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM yyyy"
    return formatter.string(from: self)
  }
}
