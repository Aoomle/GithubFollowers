//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 22/10/2020.
//

import UIKit


fileprivate var container: UIView!

extension UIViewController {
  
  func showLoading() {
    container = UIView(frame: view.bounds)
    view.addSubview(container)
    
    container.backgroundColor = .systemBackground
    container.alpha = 0
    UIView.animate(withDuration: 0.25) { container.alpha = 0.8 }
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(activityIndicator)

    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
    
    activityIndicator.startAnimating()
  }
  
  func stopLoading() {
    DispatchQueue.main.async {
    container.removeFromSuperview()
    container = nil
    }
  }
  
  func showEmptyState(with message: String, in view: UIView) {
    DispatchQueue.main.async {
      let message = EmptyStateView(message: message)
      view.addSubview(message)
      message.frame = view.bounds      
    }
  }
  
  func presentAlert(title: String, message: String) {
    DispatchQueue.main.async {
      let alertView = CustomAlertController(title: title, message: message)
      alertView.modalPresentationStyle = .overFullScreen
      alertView.modalTransitionStyle = .crossDissolve
      self.present(alertView, animated: true, completion: nil)
    }
  }
}


extension UIButton {
  func set(backgroundColor: UIColor, fontSize: CGFloat) {
    self.backgroundColor = .label
    self.setTitleColor(backgroundColor, for: .normal)
    self.layer.cornerRadius = 10
    self.titleLabel?.font = .systemFont(ofSize: fontSize)
    translatesAutoresizingMaskIntoConstraints = false
  }
}
