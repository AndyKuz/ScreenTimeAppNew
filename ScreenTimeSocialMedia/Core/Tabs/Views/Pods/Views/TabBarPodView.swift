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
    
    var body: some View {
        TabView {
            HStack {
                MainPodView()
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
            
            HStack {
                SettingsPodView(fetchUsersPods: fetchUsersPods)
            }
            .tabItem {
                Image(systemName: "gear")
            }
        }
        .onAppear() {
            print("set currentPod")
            FirestoreFunctions.system.currentPod = pod
        }
    }
}

