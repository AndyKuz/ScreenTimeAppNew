//
//  AuthDataResultModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/20/23.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?

    init(user: FirebaseAuth.User) {
        self.uid = user.uid
        self.email = user.email
    }
}
