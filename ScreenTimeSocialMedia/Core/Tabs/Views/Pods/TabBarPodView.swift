//
//  TabBarPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/24/23.
//

import SwiftUI

struct TabBarPodView: View {
    var pod: Pods
    
    var body: some View {
        TabView {
            HStack {
                MainPodView(pod: pod)
            }
                .tabItem {
                    Image(systemName: "house.fill")
                }
            
            HStack {
                ChatPodView(pod: pod)
            }
                .tabItem {
                    Image(systemName: "message.fill")
                }
        }
    }
}

