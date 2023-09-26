//
//  ScreenTImeMonitorHandlerViewModel.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/12/23.
//

import Foundation
import DeviceActivity

class ScreenTimeMonitorHandlerViewModel: DeviceActivityMonitor{
    override func eventDidReachThreshold(
        _ event: DeviceActivityEvent.Name,
        activity: DeviceActivityName
    ) {
        super.eventDidReachThreshold(event, activity: activity)
        
        let schedule = DeviceActivityCenter().schedule(for: activity)
    }
    
}
