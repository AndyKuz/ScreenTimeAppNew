//
//  MyReportExtension.swift
//  MyReportExtension
//
//  Created by Andrew Kuznetsov on 10/14/23.
//

import DeviceActivity
import SwiftUI

@main
struct MyReportExtension: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            return TotalActivityView(totalActivity: totalActivity)
        }
        
        PieChartReport { totalActivity in
            return PieChartView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
