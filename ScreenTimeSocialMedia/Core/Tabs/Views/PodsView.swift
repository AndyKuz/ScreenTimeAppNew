//
//  PodsView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/11/23.
//

import SwiftUI

// enum containing different pod types
// TODO - add water and gym types
enum groupType: String, CaseIterable {
    case screenTime = "Screen Time"
}

struct PodsView: View, Identifiable {
    var id = UUID()
    let podName: String
    let group: groupType
    let timeFrame: Double
    let totalNumStrikes: Int
    
    // based on the chosen case from groupType enum assign a emoji representation
    var groupEmoji: String{
        switch(group) {
        case .screenTime:
            return "⏳"
        }
        
    }

    var body: some View {
        // when the pod is clicked on from the HomeView navigate to its MainView
        NavigationLink(destination: TabBarPodView(podName: podName, podType: group, timeframe: timeFrame, totalNumStrikes: totalNumStrikes)) {
            HStack {
                Text(podName)
                    .font(.title2)
                    .bold()
                Spacer()
                Text(groupEmoji)
                    .font(.subheadline)
            }
            .padding(.horizontal)
        }
        .frame(height: 80)
    }
}
