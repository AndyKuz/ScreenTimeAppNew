//
//  GoalsView.swift
//  ScreenTime
//
//  Created by Andrew Kuznetsov on 9/4/23.
//

import SwiftUI

struct FriendsView: View {
    var body: some View {
        TabView {
            FriendsListView()
                .tabItem {
                    Text("Friends")
                }
            FriendsSearchView()
                .tabItem {
                    Image(systemName: "person.badge.plus")
                    Text("Search")
                }
            FriendsRequestView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Requests")
                }
        }
        .frame(alignment: .top)
    }
}

#Preview {
    FriendsView()
}
