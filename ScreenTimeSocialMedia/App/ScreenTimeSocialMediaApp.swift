//
//  ScreenTimeApp.swift
//  ScreenTime
//
//  Created by Andrew Kuznetsov on 9/4/23.
//

import SwiftUI
import Firebase


@main
struct ScreenTimeApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationView {
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
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Configured Firebase")
        return true
    }
}
