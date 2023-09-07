//
//  User.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/6/23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let username: String
    let email: String
    
    var firstLetter: String {
        if let firstCharacter = username.first {
            return String(firstCharacter).capitalized
        }
        return ""
    }
    
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, username: "AndyKuz", email: "andrew.kuz137@gmail.com")
}
