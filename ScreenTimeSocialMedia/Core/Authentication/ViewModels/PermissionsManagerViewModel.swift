//
//  PermissionsManagerViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/9/23.
//

import Foundation
import FamilyControls

class PermissionsManagerViewModel: ObservableObject{
    func screenTimeRequestAuth() {
        let ac = AuthorizationCenter.shared
        Task {
            do{
                try await ac.requestAuthorization(for: .individual)
                print("SUCCESS")
            } catch {
                print("FAILED")
            }
        }
    }
}
