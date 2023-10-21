//
//  MessageModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/5/23.
//

import Foundation
import Firebase

struct Messages: Identifiable {
    let id = UUID()
    let userID: String
    let username: String
    let text: String
    let createdAt: Date
}
