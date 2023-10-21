//
//  TabBarPodView.swift
//  ScreenTimeSocialMedia
//
//  Created by Andrew Kuznetsov on 9/24/23.
//

import SwiftUI

struct TabBarPodView: View {
    var pod: Pods
    var fetchUsersPods: () -> Void
    
    @State private var showAlert = false
    @State private var selectedTab = 0
    
    var body: some View {
        TabView {
            HStack {
                MainPodView()
            }
            .tabItem {
                Image(systemName: "house.fill")
            }
            .tag(0)
            
            HStack {
                PersonalScreenTimeView()
            }
            .tabItem {
                Image(systemName: "hourglass")
            }
            .tag(1)
            
            HStack {
                ChatPodView()
            }
            .tabItem {
                Image(systemName: "message.fill")
            }
            .tag(2)
            
            HStack {
                SettingsPodView(fetchUsersPods: fetchUsersPods)
            }
            .tabItem {
                Image(systemName: "gear")
            }
            .tag(3)
        }
        .onAppear() {
            print("set currentPod")
            FirestoreFunctions.system.currentPod = pod
        }
    }
}

