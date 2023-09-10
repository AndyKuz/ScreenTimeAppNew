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
        guard let storedPasswordData = readData(service: "Kuzy", account: username) else { return false }
        if let storedPasswordString = String(data: storedPasswordData, encoding: .utf8) {
            return storedPasswordString == passwordEntered
        }
        return false
    }

    func performSignUp(username: String, passwordEntered: String) -> Bool {
        if readData(service: "kuzy", account: username) != nil{
            print("EXISTS")
            return false
        }
        guard let passwordData = passwordEntered.data(using: .utf8) else { exit(EXIT_FAILURE) }
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
        guard let passwordNewData = passwordNew.data(using: .utf8) else { return false }
        updateData(passwordNewData, service: "Kuzy", account: username)
        return true
    }


}

