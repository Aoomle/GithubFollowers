//
//  CustomAlertController.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 05/10/2020.
//

import UIKit

class CustomAlertController: UIViewController {
  
  fileprivate let setTitle: UILabel = {
    var title = UILabel()
    title.font = .boldSystemFont(ofSize: 18)
    title.text = "Title"
    title.translatesAutoresizingMaskIntoConstraints = false
    title.textColor = .label
    title.textAlignment = .center
    return title
  }()
  
  
  fileprivate let setMessage: UITextView = {
    var tv = UITextView()
    tv.text = "There is a problem with your internet connection, please try again later. If the problem presist, contact us +2348146191761"
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.font = .monospacedDigitSystemFont(ofSize: 14, weight: .regular)
    tv.backgroundColor = .clear
    tv.textAlignment = .center
    tv.textColor = .label
    tv.isScrollEnabled = false
    tv.isUserInteractionEnabled = false
    return tv
  }()
  
  fileprivate let setButton: UIButton = {
    let bt = UIButton(type: .system)
    bt.titleLabel?.font = .systemFont(ofSize: 18)
    bt.setTitle("Button", for: .normal)
    bt.setTitleColor(.systemBackground, for: .normal)
    bt.backgroundColor = .label
    bt.layer.cornerRadius = 10
    bt.translatesAutoresizingMaskIntoConstraints = false
    return bt
  }()
  
  
 fileprivate let alertView: UIView = {
    var v = UIView()
    v.layer.cornerRadius = 10
    v.layer.borderWidth = 2
    v.layer.borderColor = UIColor.systemGray3.cgColor
    v.translatesAutoresizingMaskIntoConstraints = false
    v.backgroundColor = .systemBackground
    return v
  }()
  
  fileprivate var alertTitle: String?
  fileprivate var message: String?
  fileprivate var button: String?
  
  init(title: String, message: String) {
    super.init(nibName: nil, bundle: nil)
    self.alertTitle = title
    self.message = message
    self.button = "Ok"
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(white: 0.2, alpha: 0.75)
    view.addSubview(alertView)
    setupUI()
    NSLayoutConstraint.activate([
      alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      alertView.widthAnchor.constraint(equalToConstant: 240),
      alertView.heightAnchor.constraint(equalToConstant: 180)
    ])
  }
  
  fileprivate func setupUI() {
    alertView.addSubview(setTitle)
    alertView.addSubview(setMessage)
    alertView.addSubview(setButton)
    setTitle.text = alertTitle
    setMessage.text = message
    setButton.setTitle(button, for: .normal)
    
    setButton.addTarget(self, action: #selector(dismissAlertView), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      setTitle.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 20),
      setTitle.leadingAnchor.constraint(equalTo: alertView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      setTitle.bottomAnchor.constraint(equalTo: setMessage.safeAreaLayoutGuide.topAnchor, constant: 0),
      setTitle.trailingAnchor.constraint(equalTo: alertView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      
      setMessage.topAnchor.constraint(equalTo: setTitle.safeAreaLayoutGuide.bottomAnchor, constant: 15),
      setMessage.leadingAnchor.constraint(equalTo: alertView.safeAreaLayoutGuide.leadingAnchor),
      setMessage.trailingAnchor.constraint(equalTo: alertView.safeAreaLayoutGuide.trailingAnchor),
      setMessage.bottomAnchor.constraint(equalTo: setButton.safeAreaLayoutGuide.topAnchor),
      
      setButton.bottomAnchor.constraint(equalTo: alertView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      setButton.heightAnchor.constraint(equalToConstant: 44),
      setButton.leadingAnchor.constraint(equalTo: alertView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      setButton.trailingAnchor.constraint(equalTo: alertView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      
    ])
    
  }
  
  @objc fileprivate func dismissAlertView() {
    dismiss(animated: true, completion: nil)
  }
}

