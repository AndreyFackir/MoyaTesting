//
//  UserService.swift
//  MoyaTesting
//
//  Created by Андрей Яфаркин on 22.01.2023.
//

import Foundation
import Moya

enum UserService {
  case createUser(name: String)
  case readUser
  case updateUser(id: Int, name: String)
  case deleteUser(id: Int)
}

// MARK: - TargetType

extension UserService: TargetType {
  public var baseURL: URL {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/") else { return .init(fileURLWithPath: "")}
    return url
  }
  
  public var path: String {
    switch self {
      case .readUser, .createUser(_):
        return "users"
      case .updateUser(let id, _), .deleteUser(let id):
        return "users/\(id)"
    }
  }
  
  public var method: Moya.Method {
    switch self {
      case .createUser(_):
        return .post
      case .readUser:
        return .get
      case .updateUser(_, _):
        return .put
      case .deleteUser(_):
        return .delete
    }
  }
  
  public var task: Task {
    switch self {
      case .createUser(let name), .updateUser(_ , let name):
        return .requestParameters(parameters: ["name" : name], encoding: JSONEncoding.default)
      case .readUser, .deleteUser(_):
        return .requestPlain
    }
  }
  
  public var headers: [String : String]? {
    return ["Content-Type": "application/json"]
  }
}
