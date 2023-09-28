//
//  SignUpViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/17/23.
//

import Foundation

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
                let user = try await AuthenticationManager.shared.createUser(email: email, password: password)
                FireBaseFunctions().signUpFireBase(username: username, email: user.email ?? "", uid: user.uid)
                self.navigateToNextView = true
                
            } catch {
                self.error = "error while signing up"
                print("Error while signing up: \(error.localizedDescription)")
            }
        }
    }
}
