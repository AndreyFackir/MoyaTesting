//
//  CollectionViewCell.swift
//  MoyaTesting
//
//  Created by Андрей Яфаркин on 19.01.2023.
//

import UIKit


final class CollectionViewCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Properties
  
  
  private let title: UILabel = {
    let element = UILabel()
    element.translatesAutoresizingMaskIntoConstraints = false
    element.text = "MOYAAA"
    return element
  }()
  
  private let userName: UILabel = {
    let element = UILabel()
    element.translatesAutoresizingMaskIntoConstraints = false
    element.textColor = .gray
    element.text = "ADADADAD"
    return element
  }()
  
  // MARK: - Actions
  
  func configureCell(model: User) {
    title.text = "\(model.id)"
    userName.text = model.name
    
  }
  
}
// MARK: - Setup

private extension CollectionViewCell {
  
  func setup() {
    setupViews()
    setConstraints()
  }
  
  func setupViews() {
    addSubview(title)
    addSubview(userName)
    layer.cornerRadius = 15
    backgroundColor = .white
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      title.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      title.widthAnchor.constraint(equalToConstant: 100),
      
      userName.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 10),
      userName.topAnchor.constraint(equalTo: topAnchor, constant: 10)
    ])
  }
}
