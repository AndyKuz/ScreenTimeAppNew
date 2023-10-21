//
//  LoginViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/17/23.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var error: String?
    @Published var navigateToNextView = false
    
    @Published var email = ""
    @Published var password = ""

    func signIn() {
        // basic error handling
        if email.isEmpty && password.isEmpty{
            self.error = "no email or password found"
            return
        } else if email.isEmpty {
            self.error = "no email found"
            return
        } else if password.isEmpty {
            self.error = "no password found"
            return
        }

        Task {
            do {
                _ = try await AuthenticationManager.shared.signIn(email: email, password: password)
                self.navigateToNextView = true
            } catch {
                print("signIn(): Error while loging in: \(error.localizedDescription)")
                self.error = error.localizedDescription
            }
        }
    }
}
