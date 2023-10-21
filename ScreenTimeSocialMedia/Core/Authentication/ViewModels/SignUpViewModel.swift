//
//  SignUpViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/17/23.
//

import Foundation
import Firebase
import FirebaseFirestore

@MainActor
final class SignUpViewModel: ObservableObject {
    @Published var error: String?
    @Published var navigateToNextView = false
    
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""

    func signUp(){
        // basic error handling
        if email.isEmpty && password.isEmpty{
            self.error = "no email, password, or username found"
            return
        } else if email.isEmpty {
            self.error = "no email found"
            return
        } else if password.isEmpty {
            self.error = "no password found"
            return
        } else if username.isEmpty {
            self.error = "no username found"
        }

        Task {
            do {
                // firebase Auth
                let user = try await AuthenticationManager.shared.createUser(email: email, password: password)
                AuthenticationManager.shared.setUsername(username: username) // sets .displayName
                // sets firestore
                self.signUpFireBase(username: username, email: user.email ?? "", uid: user.uid)
                self.navigateToNextView = true
                
            } catch {
                self.error = error.localizedDescription
                print("signUp(): Error while signing up: \(error.localizedDescription)")
            }
        }
    }
    
    func signUpFireBase(username:String, email:String, uid:String) {
        Firestore.firestore().collection("users").document(uid).setData([
            "username": username,
            "email": email
        ]) { err in
            if let err = err {
                print("signUpFirebase(): Error writing document: \(err)")
            } else {
                print("signUpFirebase(): Document successfully written!")
            }
        }
    }
}


