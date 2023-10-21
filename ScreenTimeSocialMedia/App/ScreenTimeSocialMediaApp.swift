//
//  ScreenTimeApp.swift
//  ScreenTime
//
//  Created by Andrew Kuznetsov on 9/4/23.
//

import SwiftUI
import Firebase
import UserNotifications

@main
struct ScreenTimeApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if let _ = Auth.auth().currentUser {
                    TabBarView()
                } else {
                    LoginView()
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    // User Defaults between app and DeviceActivityMonitorExtension
    let sharedDefaults = UserDefaults(suiteName: "group.GB457U8UXN.com.ScreenTimeMonitor")
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure() // configure Firebase
        return true
    }
}
