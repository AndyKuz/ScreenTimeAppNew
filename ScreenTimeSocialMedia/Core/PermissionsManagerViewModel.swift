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
    func screenTimeRequestAuth(completion: @escaping (Bool) -> Void) {
        let center = AuthorizationCenter.shared
        Task {
            do {
                try await center.requestAuthorization(for: .individual)
                completion(true)
            } catch {
                print("screenTimeRequestAuth(): failed to get screentime authorization")
                completion(false)
            }
        }
    }
    
    // returns true if screenTime Authorized and false if not
    func screenTimeAuth() -> Bool {
        var res: Bool = false
        
        let center = AuthorizationCenter.shared
        let cancellable = center.$authorizationStatus
            .sink() {_ in 
            switch center.authorizationStatus {
            case .notDetermined:
                res =  false
                break
            case .denied:
                res = false
                break
            case .approved:
                res = true
                break
            @unknown default:
                res = false
                break
            }
        }
        return res
    }
    
    func notificationsRequest() {
        let center = UNUserNotificationCenter.current()

        // Request authorization for notifications
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if let error = error {
                print("notificationsRequest(): error getting notification authorization \(error)")
            }
        }

    }
}
