//
//  LoginViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Chad Baker on 9/19/23.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}