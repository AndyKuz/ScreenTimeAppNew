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
    static let totalActivity = Self("Total Activity")
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
        let roundedHours = (hours * 10.0).rounded() / 10.0 // round to 1 decimal point
        return roundedHours
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
        let roundedHours = (hours * 10.0).rounded() / 10.0 // round to 1 decimal point
        return roundedHours
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
        let roundedHours = (hours * 10.0).rounded() / 10.0 // round to 1 decimal point
        return roundedHours
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

struct TotalActivityReport: DeviceActivityReportScene {
    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .totalActivity
    
    // Define the custom configuration and the resulting view for this report.
    let content: (String) -> TotalActivityView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> String {
        // Reformat the data into a configuration that can be used to create
        // the report's view.
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        return formatter.string(from: totalActivityDuration) ?? "No activity data"
    }
}
