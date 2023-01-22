//
//  ViewController.swift
//  MoyaTesting
//
//  Created by Андрей Яфаркин on 19.01.2023.
//

import UIKit

final class ViewController: UIViewController {
  
  let viewModel = FirstViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  // MARK: - Properties
  
  private let mainCollectionView: UICollectionView = {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, environ in
      let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1)))
      item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      return section
    }
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.translatesAutoresizingMaskIntoConstraints = false
    collection.showsVerticalScrollIndicator = false
    collection.backgroundColor = .gray
    print("AF")
    return collection
  }()
  
  // MARK: - Methods
  
  @objc private func plusButtonTapped() {
    viewModel.addUser {
      self.mainCollectionView.reloadData()
    }
  }
}

// MARK: -  Setup
private extension ViewController {
  func setup() {
    setupViews()
    setConstraints()
    configureNavBar()
    viewModel.fetchUsers { [ weak self] in
      self?.mainCollectionView.reloadData()
    }
  }
  
  func setupViews() {
    view.backgroundColor = .white
    title = "Moya Test"
    view.addSubview(mainCollectionView)
    mainCollectionView.dataSource = self
    mainCollectionView.delegate = self
    mainCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "list")
  }
  
  func configureNavBar() {
    let plusImage = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
    navigationController?.topViewController?.navigationItem.rightBarButtonItem = plusImage
    plusImage.tintColor = .green
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.users.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "list", for: indexPath) as? CollectionViewCell else { return .init()}
    cell.configureCell(model: viewModel.users[indexPath.item])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let user = viewModel.users[indexPath.item]
    viewModel.updateUser(user: user, index: indexPath.item) {
      self.mainCollectionView.reloadData()
    }
  }
}


