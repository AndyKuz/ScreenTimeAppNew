//
//  ScreenTimeDisplayView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 10/14/23.
//

import SwiftUI
import DeviceActivity

struct ScreenTimeDisplayView: View {

    @State private var context: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
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
        VStack() {
            DeviceActivityReport(context, filter: filter)
        }
    }
}
