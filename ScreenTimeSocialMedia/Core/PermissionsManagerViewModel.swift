//
//  PermissionsManagerViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/9/23.
//

import Foundation
import FamilyControls
import UserNotifications

struct PermissionsManagerViewModel {
    func screenTimeRequestAuth(completion: @escaping () -> Void) {
        let center = AuthorizationCenter.shared
        Task {
            do {
                try await center.requestAuthorization(for: .individual)
                print("REQUESTED SCREENTIME AUTH")
            } catch {
                print("FAILED TO REQUEST SCREENTIME AUTH")
            }
        }
        completion()
    }
    
    // returns true if screenTime Auth'd and false if not
    func screenTimeAuth() -> Bool {
        let center = AuthorizationCenter.shared
        
        switch center.authorizationStatus {
        case .notDetermined:
            return false
        case .denied:
            return false
        case .approved:
            return true
        @unknown default:
            return false // handles unknown case
        }
    }
    
    func notificationsRequest() {
        let center = UNUserNotificationCenter.current()

        // Request authorization for notifications
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("push notifications enabled successfully")
            } else {
                print("push notifications disabled")
            }
        }

    }
}
