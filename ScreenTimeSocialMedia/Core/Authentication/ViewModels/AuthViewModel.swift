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

    func performSignUp(username: String, passwordEntered: String) -> Bool {
        if readData(service: "kuzy", account: username) != nil{
            return false
        }
        let passwordData = passwordEntered.data(using: .utf8)
        saveData(passwordData, service: "Kuzy", account: username)
        return true
    }

    func updatePassword(username: String, passwordOld: String, passwordNew: String) -> Bool {
        guard let storedPasswordData = readData(service: "Kuzy", account: username) else {
            return false
        }
        guard let storedPasswordString = String(data: storedPasswordData, encoding: .utf8) else {
            return false
        }
        guard storedPasswordString == passwordOld else {
            return false
        }
        let passwordNewData = passwordNew.data(using: .utf8)
        updateData(passwordNewData, service: "Kuzy", account: username)
        return true
    }


}

