//
//  DeviceActivityMonitorExtension.swift
//  MyMonitorExtension
//
//  Created by Andrew Kuznetsov on 10/7/23.
//

import DeviceActivity
import UserNotifications

// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class MyMonitorExtension: DeviceActivityMonitor {
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        // Handle the end of the interval.
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        
        // sets up UserDefaults for app group shared between app and extension
        let sharedDefaults = UserDefaults(suiteName: "group.GB457U8UXN.com.ScreenTimeMonitor")
        
        // sends over eventName to app
        sharedDefaults?.set("\(event.rawValue)", forKey: "sharedDataKey")
        sharedDefaults?.synchronize() // Ensure data is saved immediately
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        
        // Handle the warning before the interval starts.
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        
        // Handle the warning before the interval ends.
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        
        // Handle the warning before the event reaches its threshold.
    }
}
