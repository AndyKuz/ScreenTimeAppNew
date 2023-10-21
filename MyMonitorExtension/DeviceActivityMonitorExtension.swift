//
//  DeviceActivityMonitorExtension.swift
//  MyMonitorExtension
//
//  Created by Andrew Kuznetsov on 10/7/23.
//

import DeviceActivity
import UserNotifications
import CoreFoundation

// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class MyMonitorExtension: DeviceActivityMonitor {
    
    // post a Darwin Notification with func call and associated podID
    func sendFunctionRequestToMainApp(notifName: String, podID: String) {
        DarwinNotificationCenter.shared.postNotification(DarwinNotification.Name("\(podID).\(notifName)"))
    }

    
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        sendFunctionRequestToMainApp(notifName: "intervalStarted", podID: activity.rawValue)
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        sendFunctionRequestToMainApp(notifName: "threshold", podID: activity.rawValue)
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
