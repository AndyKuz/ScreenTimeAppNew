//
//  LoginViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/17/23.
//

import UIKit
import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var error: String?
    @Published var navigateToNextView = false
    
    @Published var email = ""
    @Published var password = ""

    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            self.error = "no email or password found"
            return
        }

        Task {
            do {
                _ = try await AuthenticationManager.shared.signIn(email: email, password: password)
                self.navigateToNextView = true
            } catch {
                print("Error while loging in: \(error.localizedDescription)")
                self.error = "error in login"
            }
        }
    }
}
