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
    // User Defaults between app and DeviceActivityMonitorExtension
    let sharedDefaults = UserDefaults(suiteName: "group.GB457U8UXN.com.ScreenTimeMonitor")
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(handleDefaultsChange), name: UserDefaults.didChangeNotification, object: sharedDefaults)   // add observer to sharedDefaults
        FirebaseApp.configure() // configure Firebase
        return true
    }
    
    @objc func handleDefaultsChange() {
        // Handle UserDefaults changes here
        if let sharedData = sharedDefaults?.string(forKey: "sharedDataKey") {
            // Perform action with sharedData
            print("Received data from app: \(sharedData)")
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Handle how the notification should be presented in the foreground
        completionHandler([.alert, .sound, .badge])
    }
}
