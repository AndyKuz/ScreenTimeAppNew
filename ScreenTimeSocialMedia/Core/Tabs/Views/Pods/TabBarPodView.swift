//
//  TabBarPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/24/23.
//

import SwiftUI

struct TabBarPodView: View {
    var podName: String
    var podType: groupType
    var timeframe: Double
    var totalNumStrikes: Int
    
    var body: some View {
        TabView {
            HStack {
                MainPodView(podName: podName, podType: podType, timeframe: timeframe, totalNumStrikes: totalNumStrikes)
            }
                .tabItem {
                    Image(systemName: "house.fill")
                }
            
            HStack {
                ChatPodView()
            }
                .tabItem {
                    Image(systemName: "message.fill")
                }
        }
    }
}

#Preview {
    TabBarPodView(podName: "podName", podType: .screenTime, timeframe: 3, totalNumStrikes: 7)
}
