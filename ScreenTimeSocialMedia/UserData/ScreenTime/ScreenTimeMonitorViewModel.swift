//
//  ScreenTimeMonitorModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/12/23.
//

import Foundation
import DeviceActivity
import FamilyControls

struct ScreenTimeMonitorViewModel {
    // monitors from beginning of the day to end of the day
    let schedule = DeviceActivitySchedule(
        intervalStart: DateComponents(hour: 0, minute: 0, second: 0),
        intervalEnd: DateComponents(hour: 23, minute: 59, second: 59),
        repeats: true
    )
    
    let thresholdHours: Int
    let selection: FamilyActivitySelection
    let center = DeviceActivityCenter()
    
    func startMonitoring() {
        let event = DeviceActivityEvent(
            applications: selection.applicationTokens,
            categories: selection.categoryTokens,
            webDomains: selection.webDomainTokens,
            threshold: DateComponents(hour: thresholdHours)
        )
        
        let activity = DeviceActivityName("MyApp.ScreenTime")
        let eventName = DeviceActivityEvent.Name("MyApp.UUID")
        
        do {
            try center.startMonitoring(
                activity,
                during: schedule,
                events: [
                    eventName: event
                ]
            )
        } catch {
            print("Error starting ScreenTimeMonitoring")
        }
        
    }
    
}

