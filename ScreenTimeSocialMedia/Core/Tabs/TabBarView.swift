//
//  TabBarView.swift
//  ScreenTime
//
//  Created by Andrew Kuznetsov on 9/4/23.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            VStack {
                HomeView()
            }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            VStack {
                FriendsView()
            }
                .tabItem {
                    Image(systemName: "person.badge.plus")
                    Text("Friends")
                }
            VStack {
                ProfileView()
            }
                .tabItem {
                    Image(systemName: "gear")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    TabBarView()
}
