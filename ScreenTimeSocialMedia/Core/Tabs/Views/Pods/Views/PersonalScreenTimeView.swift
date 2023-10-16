//
//  PersonalScreenTimeView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/15/23.
//

import SwiftUI
import DeviceActivity

struct PersonalScreenTimeView: View {
    @ObservedObject var db = FirestoreFunctions.system
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
                of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad]),
        applications: ScreenTimeViewModel().savedSelection()!.applicationTokens,
        categories: ScreenTimeViewModel().savedSelection()!.categoryTokens,
        webDomains: ScreenTimeViewModel().savedSelection()!.webDomainTokens
    )
    
    var body: some View {
        let context: DeviceActivityReport.Context
            if let timeframe = db.currentPod.goal {
                print("timeframe is \(timeframe)")
                // display pie graph out of n hours based on the screentime goal of pod/
                context = DeviceActivityReport.Context(rawValue: (timeframe == 2) ? "2 Hour Pie Chart" : (timeframe == 3) ? "3 Hour Pie Chart" : (timeframe == 4) ? "4 Hour Pie Chart" : "5 Hour Pie Chart")
            } else {
                context = DeviceActivityReport.Context(rawValue: "5 Hour Pie Chart")
            }

            return ZStack {
                DeviceActivityReport(context, filter: filter)
            }
    }
}
