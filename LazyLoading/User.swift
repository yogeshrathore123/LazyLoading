//
//  User.swift
//  LazyLoading
//
//  Created by Yogesh Rathore on 17/04/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "avatar"
    }
}
