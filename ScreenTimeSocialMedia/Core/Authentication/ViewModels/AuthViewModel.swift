//
//  AuthViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/6/23.
//

import Foundation
import AuthenticationServices

class AuthViewModel: ObservableObject {
    // this function will log the user in
    func performLogin(username: String, passwordEntered: String) -> Bool {
        // uses the readData function to return the encrpyted password
        guard let storedPasswordData = readData(service: "Kuzy", account: username) else { return false }
        // checks if the data that was returned can be dycrypted
        if let storedPasswordString = String(data: storedPasswordData, encoding: .utf8) {
            // makes sure the the password stored with this username in keychain is the same as the one that was entered
            return storedPasswordString == passwordEntered
        }
        return false
    }

    // this function will create an account for the user and save the data
    func performSignUp(username: String, passwordEntered: String) -> Bool {
        // uses the readData function to make sure that this username does not already exist
        if readData(service: "kuzy", account: username) != nil{
            print("EXISTS")
            return false
        }
        // encrypts the password entered by the user
        guard let passwordData = passwordEntered.data(using: .utf8) else { exit(EXIT_FAILURE) }
        // uses the saveData function to save the encrypted password and username
        saveData(passwordData, service: "Kuzy", account: username)
        return true
    }

    // this function allows the user to update their password
    func updatePassword(username: String, passwordOld: String, passwordNew: String) -> Bool {
        enum UpdateErrors: Error {
            case samePassword
            case wrongPassword
        }

        // retrieves encrypted password that was stored with the username
        guard let storedPasswordData = readData(service: "Kuzy", account: username) else {
            return false
        }
        // dycrypts the data back into a string
        guard let storedPasswordString = String(data: storedPasswordData, encoding: .utf8) else {
            return false
        }
        // makes sure that that password that was stored and the password entered by the user are the same
        guard storedPasswordString == passwordOld else {
            return false
        }
        // encrypts new password
        guard let passwordNewData = passwordNew.data(using: .utf8) else { return false }
        // updates the users password
        updateData(passwordNewData, service: "Kuzy", account: username)
        // returns true if ran successfully
        return true
    }


}

