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
    var currentStreak: Int? // used for displaying current streak for each pod
    var numStrikes: Int?    // used for displaying numStrikes for each pod
    
    init(username: String, userID: String, currentStreak: Int? = 0, numStrikes: Int? = 0) {
        self.username = username
        self.uid = userID
        self.currentStreak = currentStreak
        self.numStrikes = numStrikes
    }
}
