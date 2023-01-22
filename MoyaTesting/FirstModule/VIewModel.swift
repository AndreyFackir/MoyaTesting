//
//  VIewModel.swift
//  MoyaTesting
//
//  Created by Андрей Яфаркин on 19.01.2023.
//

import Foundation
import Moya

final class FirstViewModel {

  var users = [User]()
  var provider = MoyaProvider<UserService>()

  
  // MARK: - Methods
  func fetchUsers(completion: @escaping () -> ()) {
    provider.request(.readUser) { result in
      switch result {
        case .success(let response):
          let users = try! JSONDecoder().decode([User].self, from: response.data)
          DispatchQueue.main.async {
            self.users = users
            completion()
          }
        case .failure(let error):
          print(error.localizedDescription)
      }
    }
  }
  
  func addUser(completion: @escaping () -> ()) {
    let sydCrosby = User(id: 87, name: "Sydney Crosby")
    provider.request(.createUser(name: sydCrosby.name)) { result in
      switch result {
          
        case .success(let response):
          let newUser = try! JSONDecoder().decode(User.self, from: response.data)
          DispatchQueue.main.async {
            self.users.insert(newUser, at: 0)
            completion()
          }
        case .failure(let error):
          print(error.localizedDescription)
      }
    }
  }
  
  func updateUser(user: User, index: Int, completion: @escaping () -> ()) {
    provider.request(.updateUser(id: user.id, name: "Modified " + user.name)) { result in
      switch result {
          
        case .success(let response):
          let modifyUser = try! JSONDecoder().decode(User.self, from: response.data)
          DispatchQueue.main.async {
            self.users[index] = modifyUser
            completion()
          }
        case .failure(let error):
          print(error.localizedDescription)
      }
    }
  }
  
  func deleteUser(user: User,index: Int, completion: @escaping () -> ()) {
    provider.request(.deleteUser(id: user.id)) { result in
      switch result {
          
        case .success(let response):
          self.users.remove(at: index)
          completion()
        case .failure(let error):
          print(error.localizedDescription)
      }
    }
  }
}
