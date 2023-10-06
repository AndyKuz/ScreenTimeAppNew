//
//  PodsView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/11/23.
//

import SwiftUI

struct PodsView: View {
    var pod: Pods
    
    // based on the chosen case from groupType enum assign a emoji representation
    var groupEmoji: String{
        switch(pod.podType!) {
        case .screenTime:
            return "⏳"
        }
        
    }

    var body: some View {
        // when the pod is clicked on from the HomeView navigate to its MainView
        NavigationLink(destination: TabBarPodView(pod: pod)) {
            HStack {
                Text(pod.title!)
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
