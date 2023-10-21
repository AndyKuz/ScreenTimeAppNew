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
        guard !email.isEmpty, !password.isEmpty else {
            self.error = "username and password empty"
            return
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
                self.error = "error while signing up"
                print("Error while signing up: \(error.localizedDescription)")
            }
        }
    }
    
    func signUpFireBase(username:String, email:String, uid:String) {
        Firestore.firestore().collection("users").document(uid).setData([
            "username": username,
            "email": email
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}


