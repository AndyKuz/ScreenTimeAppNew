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
        PieChartReport2() { totalActivity in
            return PieChartView(totalActivity: totalActivity, totalHours: 2.0)
        }
        
        PieChartReport3() { totalActivity in
            return PieChartView(totalActivity: totalActivity, totalHours: 3.0)
        }
        
        PieChartReport4() { totalActivity in
            return PieChartView(totalActivity: totalActivity, totalHours: 4.0)
        }
        
        PieChartReport5() { totalActivity in
            return PieChartView(totalActivity: totalActivity, totalHours: 5.0)
        }
        // Add more reports here...
    }
}
