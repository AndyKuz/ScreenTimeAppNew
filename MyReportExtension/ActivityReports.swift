//
//  TotalActivityReport.swift
//  MyReportExtension
//
//  Created by Andrew Kuznetsov on 10/14/23.
//

import DeviceActivity
import SwiftUI

extension DeviceActivityReport.Context {
    // If your app initializes a DeviceActivityReport with this context, then the system will use
    // your extension's corresponding DeviceActivityReportScene to render the contents of the
    // report.
    static let pieChart2Hours = Self("2 Hour Pie Chart")    // pie chart for 2 hour daily pod
    static let pieChart3Hours = Self("3 Hour Pie Chart")    // pie chart for 3 hour daily pod
    static let pieChart4Hours = Self("4 Hour Pie Chart")    // pie chart for 4 hour daily pod
    static let pieChart5Hours = Self("5 Hour Pie Chart")    // pie chart for 5 hour daily pod
    
}

struct PieChartReport2: DeviceActivityReportScene {
    let context: DeviceActivityReport.Context = .pieChart2Hours
    
    // Define the custom configuration and the resulting view for this report.
    let content: (Double) -> PieChartView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> Double {
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        let hours = totalActivityDuration / 3600 // convert from seconds to hours
        return hours
    }
    
    
}

struct PieChartReport3: DeviceActivityReportScene {
    let context: DeviceActivityReport.Context = .pieChart3Hours
    
    // Define the custom configuration and the resulting view for this report.
    let content: (Double) -> PieChartView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> Double {
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        let hours = totalActivityDuration / 3600 // convert from seconds to hours
        return hours
    }
    
    
}

struct PieChartReport4: DeviceActivityReportScene {
    let context: DeviceActivityReport.Context = .pieChart4Hours
    
    // Define the custom configuration and the resulting view for this report.
    let content: (Double) -> PieChartView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> Double {
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        let hours = totalActivityDuration / 3600 // convert from seconds to hours
        return hours
    }
    
    
}

struct PieChartReport5: DeviceActivityReportScene {
    let context: DeviceActivityReport.Context = .pieChart5Hours
    
    // Define the custom configuration and the resulting view for this report.
    let content: (Double) -> PieChartView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> Double {
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        let hours = totalActivityDuration / 3600 // convert from seconds to hours
        return hours
    }
    
    
}
