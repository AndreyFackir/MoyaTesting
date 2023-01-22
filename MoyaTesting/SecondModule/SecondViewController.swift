//
//  SecondViewController.swift
//  MoyaTesting
//
//  Created by Андрей Яфаркин on 19.01.2023.
//

import UIKit

class SecondViewController: UIViewController {
  
  var viewModel: SecondViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
  
  // MARK: - Properties
  
  private let titleLabel: UILabel = {
    let element = UILabel()
    element.translatesAutoresizingMaskIntoConstraints = false
    element.text = "VAADDADADD"
    return element
  }()
}

private extension SecondViewController {
  func setup() {
    setupViews()
    setConstraints()
  }
  
   func setupViews() {
     view.addSubview(titleLabel)
     view.backgroundColor = .brown
  }
  
   func setConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
    ])
  }
}
