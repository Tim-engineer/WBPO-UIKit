//
//  User.swift
//  WBPO-UIKit
//
//  Created by Tim Matlak on 26/05/2024.
//

import Foundation

struct User: Decodable, Hashable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
}

struct UserResponse: Decodable {
    let data: [User]
}
