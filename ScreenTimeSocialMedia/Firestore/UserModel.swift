//
//  UserModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/28/23.
//

import Foundation

struct User {
    var username: String!
    var uid: String!
    
    init(username: String, userID: String) {
        self.username = username
        self.uid = userID
    }
}
