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
            ZStack{
                HomeView()
            }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            ZStack {
                FriendsView()
            }
                .tabItem {
                    Image(systemName: "person.badge.plus")
                    Text("Friends")
                }
            ZStack {
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
