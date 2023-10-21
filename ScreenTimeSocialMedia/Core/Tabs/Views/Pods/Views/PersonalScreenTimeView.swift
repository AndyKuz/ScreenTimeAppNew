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
        applications: ScreenTimeViewModel().savedSelection()?.applicationTokens ?? Set(),
        categories: ScreenTimeViewModel().savedSelection()?.categoryTokens ?? Set(),
        webDomains: ScreenTimeViewModel().savedSelection()?.webDomainTokens ?? Set()
    )
    
    var body: some View {
        let timeframe = db.currentPod.goal
        
        // display pie graph out of x hours based on the screentime goal of pod
        let context = DeviceActivityReport.Context(rawValue: (timeframe == 2) ? "2 Hour Pie Chart" : (timeframe == 3) ? "3 Hour Pie Chart" : (timeframe == 4) ? "4 Hour Pie Chart" : "5 Hour Pie Chart")

            return ZStack {
                // in case user has not chosen what apps to monitor
                if ScreenTimeViewModel().savedSelection() == nil {
                    VStack {
                        Text("No Apps To Monitor...")
                            .padding(.horizontal)
                            .font(.title2)
                        Text("Please select them in settings")
                            .font(.title3)
                            .padding(.horizontal)
                    }
                    
                } else {
                    // display pie graph of screenTime catered to pod goal
                    DeviceActivityReport(context, filter: filter)
                }
            }
    }
}
