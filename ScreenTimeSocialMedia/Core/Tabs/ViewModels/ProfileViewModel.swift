//
//  LoginViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Chad Baker on 9/19/23.
//
import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var showLoginView = false
    func signOut() throws {
        do {
            try AuthenticationManager.shared.signOut()
            showLoginView = true
        } catch {
            print("Error signing out")
        }

    }
}
