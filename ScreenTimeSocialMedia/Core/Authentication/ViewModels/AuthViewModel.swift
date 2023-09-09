//
//  AuthViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/6/23.
//

import Foundation
import AuthenticationServices

class AuthViewModel: ObservableObject {
    func performLogin(username: String, passwordEntered: String) -> Bool {
        let storedPasswordData = readData(service: "Kuzy", account: username)
        if let storedPasswordString = String(data: storedPasswordData, encoding: .utf8) {
            return storedPasswordString == passwordEntered
        }
        return false

    }
}
